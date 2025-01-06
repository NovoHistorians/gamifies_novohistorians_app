import 'package:flutter/material.dart';
import 'dart:async';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration for the fade-in effect
    );

    // Define the fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Start the animation
    _controller.forward();

    // Navigate to the next screen after a delay
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/welcome'); // Using named route for SecondScreen
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 240, 244), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/logo.png', 
              width: 250, 
              height: 250,
            ),
            const SizedBox(height: 20),
            // Slogan with fade-in animation
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'تاريخنا.. إرثٌ يجمعنا ويُرشد طريقنا',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.brown, 
                  fontFamily: 'Cairo', 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
