import 'package:flutter/material.dart';
import 'screens/language_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calley',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2563EB),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LanguageScreen(),
        '/signup': (context) => const SignUpScreen(),     // your sign-in screen (screen 2)
        '/register': (context) => const LoginScreen(), // new sign-up screen
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}