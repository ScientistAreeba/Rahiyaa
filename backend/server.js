const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const authRoutes = require('./routes/authRoutes');
const rideRoutes = require('./routes/rideRoutes');
const db = require('./config/db');

require('dotenv').config();

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.use('/api/auth', authRoutes);
app.use('/api/rides', rideRoutes);

const PORT = process.env.PORT || 5000;

db.sync()
  .then(() => {
    app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
  })
  .catch((err) => console.error('Failed to connect to DB:', err));
