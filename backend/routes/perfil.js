
const express = require('express');
const jwt = require('jsonwebtoken');
const db = require('../db');

const router = express.Router();

// Verificar que el usuario tenga un token válido
async function autenticar(req, res, next) {
  const encabezado = req.headers.authorization;

  if (!encabezado || !encabezado.startsWith('Bearer ')) {
    return res.status(401).json({
      mensaje: 'Debes iniciar sesión para consultar tu perfil.'
    });
  }

  const token = encabezado.split(' ')[1];

  try {
    const datos = jwt.verify(token, process.env.JWT_SECRET);
    req.usuario = datos;
    next();
  } catch (error) {
    return res.status(401).json({
      mensaje: 'El token es inválido o ha expirado.'
    });
  }
}

// Consultar el perfil del usuario autenticado
router.get('/', autenticar, async (req, res) => {
  let conexion;

  try {
    conexion = await db.getConnection();

    const [filas] = await conexion.execute(
      `SELECT u.id, u.nombre, u.correo,
              p.avatar, p.presupuesto, p.periodo_presupuesto
       FROM usuarios u
       LEFT JOIN perfiles p ON p.usuario_id = u.id
       WHERE u.id = ?
       LIMIT 1`,
      [req.usuario.id]
    );

    if (filas.length === 0) {
      return res.status(404).json({
        mensaje: 'No se encontró el usuario.'
      });
    }

    return res.json({
      mensaje: 'Perfil consultado correctamente.',
      perfil: filas[0]
    });
  } catch (error) {
    console.error('Error al consultar perfil:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudo consultar el perfil.'
    });
  } finally {
    conexion?.release();
  }
});

router.put('/', autenticar, async (req, res) => {
  let { nombre, avatar, presupuesto, periodo_presupuesto } = req.body;

  const periodosValidos = ['diario', 'semanal', 'mensual'];
  if (
  nombre !== undefined &&
  (
    typeof nombre !== 'string' ||
    nombre.trim().length < 2 ||
    nombre.trim().length > 100
  )
) {
  return res.status(400).json({
    mensaje: 'El nombre debe tener entre 2 y 100 caracteres.'
  });
}

  if (
    avatar !== undefined &&
    avatar !== null &&
    (typeof avatar !== 'string' || avatar.length > 255)
  ) {
    return res.status(400).json({
      mensaje: 'El avatar debe ser un texto de máximo 255 caracteres.'
    });
  }

  if (
    presupuesto !== undefined &&
    presupuesto !== null &&
    (
      !Number.isFinite(Number(presupuesto)) ||
      Number(presupuesto) < 0 ||
      Number(presupuesto) > 99999999.99
    )
  ) {
    return res.status(400).json({
      mensaje: 'El presupuesto debe ser una cantidad válida y no negativa.'
    });
  }

  if (
    periodo_presupuesto !== undefined &&
    periodo_presupuesto !== null &&
    !periodosValidos.includes(periodo_presupuesto)
  ) {
    return res.status(400).json({
      mensaje: 'El periodo debe ser diario, semanal o mensual.'
    });
  }

  if (
    nombre === undefined &&
    avatar === undefined &&
    presupuesto === undefined &&
    periodo_presupuesto === undefined
  ) {
    return res.status(400).json({
      mensaje: 'Debes enviar al menos un dato para actualizar.'
    });
  }

if (nombre !== undefined) {
  nombre = nombre.trim();
}

  let conexion;

  try {
    conexion = await db.getConnection();
    if (nombre !== undefined) {
  await conexion.execute(
    'UPDATE usuarios SET nombre = ? WHERE id = ?',
    [nombre, req.usuario.id]
  );
}

    await conexion.execute(
      `INSERT INTO perfiles
        (usuario_id, avatar, presupuesto, periodo_presupuesto)
       VALUES (?, ?, ?, ?)
       ON DUPLICATE KEY UPDATE
         avatar = COALESCE(VALUES(avatar), avatar),
         presupuesto = COALESCE(VALUES(presupuesto), presupuesto),
         periodo_presupuesto = COALESCE(
           VALUES(periodo_presupuesto),
           periodo_presupuesto
         )`,
      [
        req.usuario.id,
        avatar === undefined ? null : avatar,
        presupuesto === undefined ? null : presupuesto,
        periodo_presupuesto === undefined ? null : periodo_presupuesto
      ]
    );

    const [filas] = await conexion.execute(
      `SELECT u.id, u.nombre, u.correo,
              p.avatar, p.presupuesto, p.periodo_presupuesto
       FROM usuarios u
       LEFT JOIN perfiles p ON p.usuario_id = u.id
       WHERE u.id = ?`,
      [req.usuario.id]
    );

    return res.json({
      mensaje: 'Perfil actualizado correctamente.',
      perfil: filas[0]
    });
  } catch (error) {
    console.error('Error al actualizar perfil:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudo actualizar el perfil.'
    });
  } finally {
    conexion?.release();
  }
});


module.exports = router;
