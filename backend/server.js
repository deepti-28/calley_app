require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// ---------- Database ----------
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log('Mongo connected'))
  .catch((err) => console.error('Mongo error:', err.message));

const User = mongoose.model(
  'User',
  new mongoose.Schema({
    name: String,
    email: { type: String, unique: true, lowercase: true, trim: true },
    password: String,
    mobile: String,
    otpHash: String,
    otpExpiry: Date,
  })
);

const List = mongoose.model(
  'List',
  new mongoose.Schema({
    name: String,
    agents: { type: Array, default: [] },
    clientId: String,
  })
);

// ---------- Email ----------
const mailer = nodemailer.createTransport({
  service: 'gmail',
  auth: { user: process.env.EMAIL_USER, pass: process.env.EMAIL_PASS },
});

// ---------- Auth middleware ----------
const auth = (req, res, next) => {
  try {
    const token = (req.headers.authorization || '').replace('Bearer ', '');
    req.user = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch {
    res.status(401).json({ message: 'Unauthorized' });
  }
};

// ---------- Health check ----------
app.get('/', (req, res) => res.json({ message: 'Mock API V2 running' }));

// ---------- Sign up ----------
app.post('/api/auth/signup', async (req, res) => {
  try {
    const { name, email, password, mobile } = req.body;
    if (!name || !email || !password || !/^\d{10}$/.test(mobile || '')) {
      return res.status(400).json({ message: 'Enter valid name, email, password and 10-digit mobile' });
    }
    if (await User.findOne({ email: email.toLowerCase() })) {
      return res.status(409).json({ message: 'Email already registered' });
    }
    const user = await User.create({
      name,
      email,
      mobile,
      password: await bcrypt.hash(password, 10),
    });
    await List.create({ name: 'Test List', clientId: user._id.toString() });
    res.status(201).json({ message: 'Signed up successfully', userId: user._id });
  } catch (e) {
    res.status(500).json({ message: 'Server error', error: e.message });
  }
});

// ---------- Login: check password, send OTP to email ----------
app.post('/api/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email: (email || '').toLowerCase() });
    if (!user || !(await bcrypt.compare(password || '', user.password))) {
      return res.status(401).json({ message: 'Wrong email or password' });
    }

    const otp = String(Math.floor(100000 + Math.random() * 900000));
    user.otpHash = await bcrypt.hash(otp, 10);
    user.otpExpiry = new Date(Date.now() + 5 * 60 * 1000);
    await user.save();

    await mailer.sendMail({
      from: process.env.EMAIL_USER,
      to: user.email,
      subject: 'Your Calley OTP',
      text: `Your OTP is ${otp}. It expires in 5 minutes.`,
    });

    res.json({ message: 'OTP sent to your email' });
  } catch (e) {
    res.status(500).json({ message: 'Could not send OTP', error: e.message });
  }
});

// ---------- Verify OTP ----------
app.post('/api/auth/verify-otp', async (req, res) => {
  try {
    const { email, otp } = req.body;
    const user = await User.findOne({ email: (email || '').toLowerCase() });
    if (
      !user ||
      !user.otpHash ||
      user.otpExpiry < new Date() ||
      !(await bcrypt.compare(String(otp), user.otpHash))
    ) {
      return res.status(400).json({ message: 'Invalid or expired OTP' });
    }

    user.otpHash = undefined;
    user.otpExpiry = undefined;
    await user.save();

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '7d' });
    res.json({ token, userId: user._id, name: user.name });
  } catch (e) {
    res.status(500).json({ message: 'Server error', error: e.message });
  }
});

// ---------- Lists (same response shape as the mock API) ----------
app.get('/api/list', auth, async (req, res) => {
  try {
    const list = await List.findOne({ clientId: req.query.userId });
    if (!list) return res.status(404).json({ message: 'List not found' });
    res.json(list);
  } catch (e) {
    res.status(500).json({ message: 'Server error', error: e.message });
  }
});

app.get('/api/list/:id', auth, async (req, res) => {
  try {
    const list = await List.findById(req.params.id);
    if (!list) return res.status(404).json({ message: 'List not found' });
    res.json(list);
  } catch (e) {
    res.status(500).json({ message: 'Server error', error: e.message });
  }
});

app.listen(process.env.PORT || 5000, () => console.log('Server running on port ' + (process.env.PORT || 5000)));