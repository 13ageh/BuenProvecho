
const express = require('express');
const db = require('../db');
const jwt = require('jsonwebtoken');


const router = express.Router();


function autenticar(req, res, next) {
  const encabezado = req.headers.authorization;

  if (!encabezado || !encabezado.startsWith('Bearer ')) {
    return res.status(401).json({
      mensaje: 'Debes iniciar sesión para realizar esta acción.'
    });
  }

  const token = encabezado.split(' ')[1];

  try {
    req.usuario = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch (error) {
    return res.status(401).json({
      mensaje: 'El token es inválido o ha expirado.'
    });
  }
}


// Consultar el catálogo de alergias
router.get('/alergias', async (req, res) => {
  let conexion;

  try {
    conexion = await db.getConnection();

    const [alergias] = await conexion.execute(
      'SELECT id, nombre FROM alergias ORDER BY nombre'
    );

    return res.json({
      mensaje: 'Alergias consultadas correctamente.',
      alergias
    });
  } catch (error) {
    console.error('Error al consultar alergias:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudieron consultar las alergias.'
    });
  } finally {
    conexion?.release();
  }
});

// Consultar el catálogo de preferencias alimenticias
router.get('/alimentacion', async (req, res) => {
  let conexion;

  try {
    conexion = await db.getConnection();

    const [preferencias] = await conexion.execute(
      'SELECT id, nombre FROM preferencias_alimenticias ORDER BY nombre'
    );

    return res.json({
      mensaje: 'Preferencias consultadas correctamente.',
      preferencias
    });
  } catch (error) {
    console.error('Error al consultar preferencias:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudieron consultar las preferencias.'
    });
  } finally {
    conexion?.release();
  }
});

router.put('/alergias', autenticar, async (req, res) => {
  const alergias = req.body.alergias;

  if (
    !Array.isArray(alergias) ||
    !alergias.every(
      id => Number.isInteger(id) && id > 0
    ) ||
    new Set(alergias).size !== alergias.length
  ) {
    return res.status(400).json({
      mensaje: 'Envía una lista válida de identificadores de alergias.'
    });
  }

  let conexion;

  try {
    conexion = await db.getConnection();
    await conexion.beginTransaction();

    if (alergias.length > 0) {
      const marcadores = alergias.map(() => '?').join(',');

      const [existentes] = await conexion.execute(
        `SELECT id FROM alergias WHERE id IN (${marcadores})`,
        alergias
      );

      if (existentes.length !== alergias.length) {
        await conexion.rollback();

        return res.status(400).json({
          mensaje: 'Una o más alergias no existen en el catálogo.'
        });
      }
    }

    await conexion.execute(
      'DELETE FROM usuario_alergias WHERE usuario_id = ?',
      [req.usuario.id]
    );

    for (const alergiaId of alergias) {
      await conexion.execute(
        `INSERT INTO usuario_alergias (usuario_id, alergia_id)
         VALUES (?, ?)`,
        [req.usuario.id, alergiaId]
      );
    }

    await conexion.commit();

    return res.json({
      mensaje: 'Alergias guardadas correctamente.',
      alergias
    });
  } catch (error) {
    if (conexion) {
      await conexion.rollback().catch(() => {});
    }

    console.error('Error al guardar alergias:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudieron guardar las alergias.'
    });
  } finally {
    conexion?.release();
  }
});

router.put('/alimentacion', autenticar, async (req, res) => {
  const preferencias = req.body.preferencias;

  if (
    !Array.isArray(preferencias) ||
    !preferencias.every(
      id => Number.isInteger(id) && id > 0
    ) ||
    new Set(preferencias).size !== preferencias.length
  ) {
    return res.status(400).json({
      mensaje: 'Envía una lista válida de identificadores de preferencias.'
    });
  }

  let conexion;

  try {
    conexion = await db.getConnection();
    await conexion.beginTransaction();

    if (preferencias.length > 0) {
      const marcadores = preferencias.map(() => '?').join(',');

      const [existentes] = await conexion.execute(
        `SELECT id FROM preferencias_alimenticias
         WHERE id IN (${marcadores})`,
        preferencias
      );

      if (existentes.length !== preferencias.length) {
        await conexion.rollback();

        return res.status(400).json({
          mensaje: 'Una o más preferencias no existen en el catálogo.'
        });
      }
    }

    await conexion.execute(
      'DELETE FROM usuario_preferencias WHERE usuario_id = ?',
      [req.usuario.id]
    );

    for (const preferenciaId of preferencias) {
      await conexion.execute(
        `INSERT INTO usuario_preferencias (usuario_id, preferencia_id)
         VALUES (?, ?)`,
        [req.usuario.id, preferenciaId]
      );
    }

    await conexion.commit();

    return res.json({
      mensaje: 'Preferencias guardadas correctamente.',
      preferencias
    });
  } catch (error) {
    if (conexion) {
      await conexion.rollback().catch(() => {});
    }

    console.error('Error al guardar preferencias:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudieron guardar las preferencias.'
    });
  } finally {
    conexion?.release();
  }
});

router.get('/mis-alergias', autenticar, async (req, res) => {
  let conexion;

  try {
    conexion = await db.getConnection();

    const [alergias] = await conexion.execute(
      `SELECT a.id, a.nombre
       FROM usuario_alergias ua
       INNER JOIN alergias a ON a.id = ua.alergia_id
       WHERE ua.usuario_id = ?
       ORDER BY a.nombre`,
      [req.usuario.id]
    );

    return res.json({
      mensaje: 'Alergias del usuario consultadas correctamente.',
      alergias
    });
  } catch (error) {
    console.error('Error al consultar alergias del usuario:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudieron consultar tus alergias.'
    });
  } finally {
    conexion?.release();
  }
});

router.get('/mis-preferencias', autenticar, async (req, res) => {
  let conexion;

  try {
    conexion = await db.getConnection();

    const [preferencias] = await conexion.execute(
      `SELECT p.id, p.nombre
       FROM usuario_preferencias up
       INNER JOIN preferencias_alimenticias p
         ON p.id = up.preferencia_id
       WHERE up.usuario_id = ?
       ORDER BY p.nombre`,
      [req.usuario.id]
    );

    return res.json({
      mensaje: 'Preferencias del usuario consultadas correctamente.',
      preferencias
    });
  } catch (error) {
    console.error(
      'Error al consultar preferencias del usuario:',
      error.message
    );

    return res.status(500).json({
      mensaje: 'No se pudieron consultar tus preferencias.'
    });
  } finally {
    conexion?.release();
  }
});


module.exports = router;
