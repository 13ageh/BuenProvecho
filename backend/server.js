const cors = require('cors');
require('dotenv').config();
const db =require('./db');
const authRoutes = require('./routes/auth');
const perfilRoutes = require('./routes/perfil');
const preferenciasRoutes = require('./routes/preferencias');
const express = require('express');
const app = express();
const recetasRoutes = require('./routes/recetas');


0

app.use(express.json());

app.use('/api/preferencias', preferenciasRoutes);
app.use(cors());
app.use('/api/auth',authRoutes);
app.use('/api/perfil',perfilRoutes);

app.use('/api/recetas', recetasRoutes);

app.get('/api/health/db', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT VERSION() AS version');

    res.json({
      estado: 'Conectado a MySQL',
      version: rows[0].version
    });
  } catch (error) {
    console.error('Error al conectar con MySQL:', error.message);

    res.status(500).json({
      estado: 'Error de conexión con MySQL'
    });
  }
});



app.get('/', (req, res) => {
  res.json({
    mensaje: '¡Bienvenido al backend de BuenProvecho!',
    estado: 'Servidor funcionando'
  });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor de BuenProvecho activo en http://localhost:${PORT}`);
});
