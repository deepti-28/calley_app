import 'package:flutter/material.dart';

const _primary = Color(0xFF2563EB);
const _navy = Color(0xFF1E3366);
const _bg = Color(0xFFF8FAFC);
const _border = Color(0xFFD0D8E4);
const _tileBg = Color(0xFFEFF5FF);

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Calling Lists sheet is visible by default (as in the design).
  // Tap the dimmed area to hide it.
  bool _showSheet = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.chevron_left, size: 34),
                      ),
                      const SizedBox(width: 8),
                      const Text('Setting',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Column(
                      children: [
                        const _ProfileCard(),
                        const SizedBox(height: 18),
                        _NavyCard(
                          title: 'PROFILE SETTINGS',
                          child: Column(
                            children: const [
                              _SettingTile(icon: Icons.public, label: 'App Language'),
                              SizedBox(height: 14),
                              _SettingTile(icon: Icons.lock_outline, label: 'Change Password'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_showSheet)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => _showSheet = false),
                  child: Container(color: Colors.black.withValues(alpha: 0.65)),
                ),
              ),
            if (_showSheet)
              const Align(
                alignment: Alignment.bottomCenter,
                child: _CallingListsSheet(),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Hello Swati',
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
              SizedBox(height: 2),
              Text('swati@cstech.in',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(height: 2),
              Text('9971125588',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(height: 2),
              Text('Parent Account: NA',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(height: 2),
              Text('Current Subscription: Calley Personal',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
      ],
    ),
  );
}

class _NavyCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _NavyCard({required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: _navy,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(title,
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: _border),
          ),
          child: child,
        ),
      ],
    ),
  );
}

class _ArrowBox extends StatelessWidget {
  const _ArrowBox();
  @override
  Widget build(BuildContext context) => Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.black, width: 1.8),
    ),
    child: const Icon(Icons.arrow_forward, size: 18, color: Colors.black),
  );
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _SettingTile({required this.icon, required this.label, this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tileBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _border),
            ),
            child: Icon(icon, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          ),
          const _ArrowBox(),
        ],
      ),
    ),
  );
}

class _CallingListsSheet extends StatelessWidget {
  const _CallingListsSheet();
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: _navy,
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text('CALLING LISTS',
              style: TextStyle(
                  color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: _border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: _tileBg,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('Select Calling List',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.sync, size: 20),
                      label: const Text('Refresh',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                decoration: BoxDecoration(
                  color: _tileBg,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text('Test List',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                    ),
                    _ArrowBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}