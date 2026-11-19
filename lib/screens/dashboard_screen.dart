import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'whats_star_bar.dart';

const _primary = Color(0xFF2563EB);
const _navy = Color(0xFF1E3366);
const _bg = Color(0xFFF8FAFC);
const _border = Color(0xFFD0D8E4);
const _softBlue = Color(0xFFEFF5FF);
const _green = Color(0xFF22C55E);

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      // NEW: side drawer (4th screen)
      drawer: const _AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // ---------- Top bar ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  // CHANGED: menu now opens the drawer instead of Settings
                  Builder(
                    builder: (ctx) => GestureDetector(
                      onTap: () => Scaffold.of(ctx).openDrawer(),
                      child: const Icon(Icons.menu,
                          size: 32, color: Color(0xFF222222)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('Dashboard',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  const Icon(Icons.headset_mic_outlined, size: 28),
                  const SizedBox(width: 18),
                  const Icon(Icons.notifications_none, size: 28),
                ],
              ),
            ),

            // ---------- Body ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                child: Column(
                  children: [
                    const _GreetingCard(),
                    const SizedBox(height: 16),
                    const Expanded(child: _LoadNumberCard()),
                    const SizedBox(height: 16),
                    // CHANGED: tap on "Star Calling Now" opens calling lists
                    WhatsStarBar(
                      onStart: () => _showCallingLists(context),
                    ),
                  ],
                ),
              ),
            ),

            // ---------- Bottom navigation ----------
            const _BottomNav(),
          ],
        ),
      ),
    );
  }
}

// ======================= NEW: Calling lists bottom sheet =======================
void _showCallingLists(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheetCtx) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                color: _navy,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: const Text('CALLING LISTS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                children: [
                  // Select Calling List + Refresh
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: _softBlue,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _border),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('Select Calling List',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: _primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.sync, color: Colors.white, size: 18),
                                SizedBox(width: 6),
                                Text('Refresh',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Test List
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(sheetCtx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CallListDashboardScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: _softBlue,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _border),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text('Test List',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _border),
                            ),
                            child: const Icon(Icons.arrow_forward, size: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ======================= NEW: Call list dashboard (3rd screen) =======================
class CallListDashboardScreen extends StatelessWidget {
  const CallListDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      drawer: const _AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // ---------- Top bar ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Builder(
                    builder: (ctx) => GestureDetector(
                      onTap: () => Scaffold.of(ctx).openDrawer(),
                      child: const Icon(Icons.menu,
                          size: 32, color: Color(0xFF222222)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('Dashboard',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  const Icon(Icons.headset_mic_outlined, size: 28),
                  const SizedBox(width: 18),
                  const Icon(Icons.notifications_none, size: 28),
                ],
              ),
            ),

            // ---------- Body ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                child: Column(
                  children: [
                    // List summary card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _border),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Test List',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w600)),
                              SizedBox(height: 4),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: '50',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: _primary)),
                                TextSpan(
                                    text: '  CALLS',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ])),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: 56,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _primary,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Text('S',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),

                    // Graph
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Image.asset(
                            'assets/images/circle.png',
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                                Icons.donut_large,
                                size: 200,
                                color: _primary),
                          ),
                        ),
                      ),
                    ),

                    // Stat cards
                    Row(
                      children: const [
                        Expanded(
                          child: _StatCard(
                            label: 'Pending',
                            count: '28',
                            bg: Color(0xFFFFEEDD),
                            bar: Color(0xFFF59E0B),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _StatCard(
                            label: 'Done',
                            count: '22',
                            bg: Color(0xFFE3F8E8),
                            bar: _green,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _StatCard(
                            label: 'Schedule',
                            count: '09',
                            bg: Color(0xFFEFE9FF),
                            bar: Color(0xFF7C3AED),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Start button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Star Calling Now',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---------- Bottom navigation (same as dashboard) ----------
            const _BottomNav(),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String count;
  final Color bg;
  final Color bar;
  const _StatCard({
    required this.label,
    required this.count,
    required this.bg,
    required this.bar,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Container(
          width: 3,
          height: 40,
          decoration: BoxDecoration(
            color: bar,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: count,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700)),
              const TextSpan(
                  text: ' Calls',
                  style: TextStyle(fontSize: 11, color: Colors.black87)),
            ])),
          ],
        ),
      ],
    ),
  );
}

// ======================= NEW: Side drawer (4th screen) =======================
class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  Widget _item(BuildContext context, IconData icon, String label,
      {VoidCallback? onTap}) =>
      ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        leading: Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
              color: Colors.white, shape: BoxShape.circle),
          child: Icon(icon, size: 20, color: const Color(0xFF222222)),
        ),
        title: Text(label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        onTap: onTap ?? () => Navigator.pop(context),
      );

  @override
  Widget build(BuildContext context) => Drawer(
    backgroundColor: _softBlue,
    width: MediaQuery.of(context).size.width * 0.75,
    shape: const RoundedRectangleBorder(),
    child: SafeArea(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: _primary,
            child: Row(
              children: [
                const _Avatar(size: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Swati',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                            text: '  • Personal',
                            style: TextStyle(
                                color: Color(0xFFFFD54F), fontSize: 12)),
                      ])),
                      SizedBox(height: 2),
                      Text('swati@cstech.in',
                          style: TextStyle(color: Colors.white, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 6),
              children: [
                _item(context, Icons.rocket_launch_outlined, 'Getting Started'),
                _item(context, Icons.cloud_sync_outlined, 'Sync Data'),
                _item(context, Icons.grid_view_outlined, 'Gamification'),
                _item(context, Icons.phone_forwarded_outlined, 'Send Logs'),
                _item(context, Icons.settings_outlined, 'Settings', onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                }),
                _item(context, Icons.headset_mic_outlined, 'Help?'),
                _item(context, Icons.person_remove_outlined,
                    'Cancel Subscription'),
                const Divider(height: 24),
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 18, 6),
                  child: Text('App Info',
                      style: TextStyle(
                          color: _primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ),
                _item(context, Icons.info_outline, 'About Us'),
                _item(context, Icons.privacy_tip_outlined, 'Privacy Policy'),
                _item(context, Icons.verified_outlined, 'Version 1.01.52'),
                _item(context, Icons.share_outlined, 'Share App'),
                _item(context, Icons.logout, 'Logout'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ======================= EXISTING CODE (unchanged) =======================
class _Avatar extends StatelessWidget {
  final double size;
  const _Avatar({this.size = 72});
  @override
  Widget build(BuildContext context) => ClipOval(
    child: Image.asset(
      'assets/images/avatar.png',
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        width: size,
        height: size,
        color: const Color(0xFFF0506E),
        child: Icon(Icons.person, color: Colors.white, size: size * 0.6),
      ),
    ),
  );
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
        const _Avatar(),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Hello Swati',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 4),
            Text('Welcome to Calley!',
                style: TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    ),
  );
}

class _LoadNumberCard extends StatelessWidget {
  const _LoadNumberCard();
  // dash_img.png already contains the whole "LOAD NUMBER TO CALL" card,
  // so only the image is shown (no second box drawn in code).
  @override
  Widget build(BuildContext context) => Image.asset(
    'assets/images/dash_img.png',
    width: double.infinity,
    fit: BoxFit.contain,
    alignment: Alignment.topCenter,
    errorBuilder: (_, __, ___) => const Icon(
        Icons.cloud_upload_outlined,
        size: 120,
        color: _primary),
  );
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();
  @override
  Widget build(BuildContext context) => Container(
    height: 82,
    decoration: const BoxDecoration(
      color: _softBlue,
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      border: Border(
        top: BorderSide(color: _primary),
        left: BorderSide(color: _primary),
        right: BorderSide(color: _primary),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Icon(Icons.home_outlined, size: 30),
        const Icon(Icons.badge_outlined, size: 30),
        Container(
          width: 80,
          height: 54,
          decoration: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(27),
          ),
          child: const Icon(Icons.play_arrow_outlined,
              color: Colors.white, size: 38),
        ),
        const Icon(Icons.phone_callback_outlined, size: 30),
        const Icon(Icons.edit_calendar_outlined, size: 30),
      ],
    ),
  );
}