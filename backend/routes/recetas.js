
const express = require('express');
const db = require('../db');

const router = express.Router();

// Consultar todas las recetas guardadas
router.get('/', async (req, res) => {
  let conexion;

  try {
    conexion = await db.getConnection();

    const [recetas] = await conexion.execute(
      `SELECT
         id,
         nombre,
         descripcion,
         imagen,
         instrucciones,
         tiempo_preparacion,
         porciones,
         costo_estimado,
         calorias,
         proteinas,
         carbohidratos,
         grasas
       FROM recetas
       ORDER BY creada_en DESC`
    );

    return res.json({
      mensaje: 'Recetas consultadas correctamente.',
      total: recetas.length,
      recetas
    });
  } catch (error) {
    console.error('Error al consultar recetas:', error.message);

    return res.status(500).json({
      mensaje: 'No se pudieron consultar las recetas.'
    });
  } finally {
    conexion?.release();
  }
});

module.exports = router;
