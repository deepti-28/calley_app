import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_service.dart';
import 'otp_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color _primary = Color(0xFF2563EB);
  static const Color _border = Color(0xFFD5DCEA);

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _onSignIn() async {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;

    if (email.isEmpty || pass.isEmpty) {
      _showMsg('Please enter your email and password');
      return;
    }

    setState(() => _loading = true);
    final r = await ApiService.login(email, pass);
    if (!mounted) return;
    setState(() => _loading = false);

    if (r['ok'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OtpScreen(email: email)),
      );
    } else {
      _showMsg((r['message'] ?? 'Login failed').toString());
    }
  }

  void _goToSignUp() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignUpScreen()),
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
                    const SizedBox(height: 40),
                    Text(
                      'Welcome',
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Please sign-in to continue',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
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
                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // TODO: forgot password
                              },
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: _goToSignUp,
                          child: Text(
                            'Sign Up',
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
                        onPressed: _loading ? null : _onSignIn,
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
                          'Sign In',
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
}