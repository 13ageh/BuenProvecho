
const express = require('express');
const bcrypt = require('bcryptjs');
const db = require('../db');
const jwt = require('jsonwebtoken');

const router = express.Router();

router.post('/register', async (req, res) => {
  const nombre = req.body.nombre?.trim();
  const correo = req.body.correo?.trim().toLowerCase();
  const password = req.body.password;

  if (!nombre || !correo || !password) {
    return res.status(400).json({
      mensaje: 'Nombre, correo y contraseña son obligatorios.'
    });
  }

  if (nombre.length > 100 || correo.length > 255) {
    return res.status(400).json({
      mensaje: 'El nombre o el correo son demasiado largos.'
    });
  }

  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo)) {
    return res.status(400).json({
      mensaje: 'El correo electrónico no es válido.'
    });
  }

  if (typeof password !== 'string' || password.length < 8) {
    return res.status(400).json({
      mensaje: 'La contraseña debe tener al menos 8 caracteres.'
    });
  }

  if (Buffer.byteLength(password, 'utf8') > 72) {
    return res.status(400).json({
      mensaje: 'La contraseña es demasiado larga.'
    });
  }

  let conexion;

  try {
    const passwordHash = await bcrypt.hash(password, 12);

    conexion = await db.getConnection();
    await conexion.beginTransaction();

    const [resultado] = await conexion.execute(
      `INSERT INTO usuarios (nombre, correo, password_hash)
       VALUES (?, ?, ?)`,
      [nombre, correo, passwordHash]
    );

    await conexion.execute(
      'INSERT INTO perfiles (usuario_id) VALUES (?)',
      [resultado.insertId]
    );

    await conexion.commit();

    return res.status(201).json({
      mensaje: '¡Cuenta creada correctamente!',
      usuario: {
        id: resultado.insertId,
        nombre,
        correo
      }
    });
  } catch (error) {
    if (conexion) {
      await conexion.rollback().catch(() => {});
    }

    if (error.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({
        mensaje: 'Ya existe una cuenta con ese correo.'
      });
    }

    console.error('Error al registrar usuario:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudo crear la cuenta.'
    });
  } finally {
    conexion?.release();
  }
});

router.post('/login', async (req, res) => {
  const correo = req.body.correo?.trim().toLowerCase();
  const password = req.body.password;

  if (!correo || !password) {
    return res.status(400).json({
      mensaje: 'Correo y contraseña son obligatorios.'
    });
  }

  let conexion;

  try {
    conexion = await db.getConnection();

    const [usuarios] = await conexion.execute(
      `SELECT id, nombre, correo, password_hash
       FROM usuarios
       WHERE correo = ?
       LIMIT 1`,
      [correo]
    );

    if (usuarios.length === 0) {
      return res.status(401).json({
        mensaje: 'Correo o contraseña incorrectos.'
      });
    }

    const usuario = usuarios[0];
    const passwordValida = await bcrypt.compare(
      password,
      usuario.password_hash
    );

    if (!passwordValida) {
      return res.status(401).json({
        mensaje: 'Correo o contraseña incorrectos.'
      });
    }

    const token = jwt.sign(
      {
        id: usuario.id,
        correo: usuario.correo
      },
      process.env.JWT_SECRET,
      { expiresIn: '2h' }
    );

    return res.status(200).json({
      mensaje: 'Inicio de sesión correcto.',
      token,
      usuario: {
        id: usuario.id,
        nombre: usuario.nombre,
        correo: usuario.correo
      }
    });
  } catch (error) {
    console.error('Error al iniciar sesión:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudo iniciar sesión.'
    });
  } finally {
    conexion?.release();
  }
});

module.exports = router;
