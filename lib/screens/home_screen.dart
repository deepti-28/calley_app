import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'whats_star_bar.dart';

const _primary = Color(0xFF2563EB);
const _navy = Color(0xFF1E3366);
const _bg = Color(0xFFF8FAFC);
const _border = Color(0xFFD0D8E4);
const _green = Color(0xFF22C55E);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _startCalling(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            children: [
              // ---------- Scrollable top part ----------
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const _GreetingCard(),
                      const SizedBox(height: 16),
                      const _InfoCard(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // ---------- Bottom buttons ----------
              WhatsStarBar(onStart: () => _startCalling(context)),
            ],
          ),
        ),
      ),
    );
  }
}

class _GreetingCard extends StatelessWidget {
  const _GreetingCard();
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
    decoration: BoxDecoration(
      color: _primary,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFFB9CCF5)),
    ),
    child: Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/avatar.png',
            width: 72,
            height: 72,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 72,
              height: 72,
              color: const Color(0xFFF0506E),
              child: const Icon(Icons.person, color: Colors.white, size: 44),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Hello Swati',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 4),
            Text('Calley Personal',
                style: TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    ),
  );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: _navy,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(22, 16, 22, 14),
          child: Text(
            'If you are here for the first time then ensure that you have uploaded the list to call from calley Web Panel hosted on https://app.getcalley.com',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15, height: 1.35),
          ),
        ),
        Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: _border),
          ),
          child: Image.asset(
            'assets/images/home_image.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
            errorBuilder: (_, __, ___) => Container(
              height: 200,
              color: Colors.white,
              alignment: Alignment.center,
              child: const Text('Add assets/images/home_image.png'),
            ),
          ),
        ),
      ],
    ),
  );
}