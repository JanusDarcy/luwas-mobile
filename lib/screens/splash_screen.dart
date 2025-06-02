import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

// Import your Login Page
import 'package:luwas_travel_app/features/auth/email_password_login/pages/login_page.dart'; // Ensure this path is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Set a timer to navigate to the Login Page after a delay.
    Timer(const Duration(seconds: 5), () {
      // ONLY handle navigation here. The controller will be disposed in the State's dispose method.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LogInPage()),
      );
    });
  }

  @override
  void dispose() {
    // This is the CORRECT and ONLY place to dispose your AnimationController
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/planeloader.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'LUWAS',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}