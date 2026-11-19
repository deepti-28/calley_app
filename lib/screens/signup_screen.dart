import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_service.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const Color _primary = Color(0xFF2563EB);
  static const Color _border = Color(0xFFD5DCEA);

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  bool _agreed = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _mobileCtrl.dispose();
    super.dispose();
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Future<void> _onSignUp() async {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    final mobile = _mobileCtrl.text.trim();

    if (name.isEmpty || email.isEmpty || pass.isEmpty || mobile.isEmpty) {
      _showMsg('Please fill in all the fields');
      return;
    }
    if (!_agreed) {
      _showMsg('Please agree to the Terms and Conditions');
      return;
    }

    setState(() => _loading = true);
    final r = await ApiService.signup(name, email, pass, mobile);
    if (!mounted) return;
    setState(() => _loading = false);

    _showMsg((r['message'] ?? (r['ok'] == true ? 'Signed up' : 'Sign up failed'))
        .toString());

    if (r['ok'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: Column(
          children: [
            // ---------- Logo ----------
            Padding(
              padding: const EdgeInsets.only(top: 28, bottom: 24),
              child: _buildLogo(),
            ),
            // ---------- White card ----------
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  border: Border(
                    top: BorderSide(color: _border, width: 1),
                    left: BorderSide(color: _border, width: 1),
                    right: BorderSide(color: _border, width: 1),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome!',
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Please register to continue',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            _buildField(
                              controller: _nameCtrl,
                              hint: 'Name',
                              suffix: const Icon(Icons.person_outline,
                                  size: 20, color: Colors.black87),
                            ),
                            const SizedBox(height: 12),
                            _buildField(
                              controller: _emailCtrl,
                              hint: 'Email address',
                              keyboardType: TextInputType.emailAddress,
                              suffix: const Icon(Icons.mail_outline,
                                  size: 20, color: Colors.black87),
                            ),
                            const SizedBox(height: 12),
                            _buildField(
                              controller: _passCtrl,
                              hint: 'Password',
                              obscure: true,
                              suffix: const Icon(Icons.lock_outline,
                                  size: 20, color: Colors.black87),
                            ),
                            const SizedBox(height: 12),
                            _buildCountryCodeField(),
                            const SizedBox(height: 12),
                            _buildField(
                              controller: _mobileCtrl,
                              hint: 'Mobile number',
                              keyboardType: TextInputType.phone,
                              suffix: const Icon(Icons.smartphone,
                                  size: 20, color: Colors.black87),
                            ),
                            const SizedBox(height: 12),
                            _buildTermsRow(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: _goToLogin,
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _onSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _loading
                            ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          'Sign Up',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Falls back to a text logo if the asset is missing.
  Widget _buildLogo() {
    return Image.asset(
      'assets/images/calley_logo.png',
      height: 52,
      errorBuilder: (_, __, ___) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.phone_in_talk, size: 40, color: _primary),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CALLEY',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF29B6F6),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'AUTOMATIC CALL DIALER',
                style: GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(String hint, Widget? suffix) {
    OutlineInputBorder border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _border, width: 1.2),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(fontSize: 13, color: Colors.black87),
      suffixIcon: suffix == null
          ? null
          : Padding(
        padding: const EdgeInsets.only(right: 4),
        child: suffix,
      ),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: border(),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primary, width: 1.4),
      ),
      border: border(),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    Widget? suffix,
    bool obscure = false,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      height: 46,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: GoogleFonts.inter(fontSize: 13),
        decoration: _decoration(hint, suffix),
      ),
    );
  }

  Widget _buildCountryCodeField() {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border, width: 1.2),
      ),
      child: Row(
        children: [
          const Text('🇮🇳', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(
            '+91',
            style: GoogleFonts.inter(fontSize: 13, color: Colors.black87),
          ),
          const Spacer(),
          const FaIcon(
            FontAwesomeIcons.whatsapp,
            size: 20,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildTermsRow() {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: _agreed,
            onChanged: (v) => setState(() => _agreed = v ?? false),
            side: const BorderSide(color: Color(0xFF9CA3AF), width: 1.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            activeColor: _primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'I agree to the ',
          style: GoogleFonts.inter(fontSize: 12, color: Colors.black87),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Terms and Conditions',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _primary,
            ),
          ),
        ),
      ],
    );
  }
}