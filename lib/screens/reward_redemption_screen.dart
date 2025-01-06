import 'package:flutter/material.dart';
import 'package:novo_historians/constants/colors.dart';
import 'package:novo_historians/screens/home_screen.dart';

class RewardRedemptionScreen extends StatefulWidget {
  final int earnedHearts;

  const RewardRedemptionScreen({required this.earnedHearts});

  @override
  _RewardRedemptionScreenState createState() =>
      _RewardRedemptionScreenState();
}

class _RewardRedemptionScreenState extends State<RewardRedemptionScreen>
    with TickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late AnimationController _checkIconAnimationController;
  late AnimationController _heartAnimationController;
  late AnimationController _buttonAnimationController;

  @override
  void initState() {
    super.initState();

    // Initializing Animation Controllers
    _textAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _checkIconAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _heartAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _buttonAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    // Start animations when screen is built
    _textAnimationController.forward();
    _checkIconAnimationController.forward();
    _heartAnimationController.forward();
    _buttonAnimationController.forward();
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _checkIconAnimationController.dispose();
    _heartAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beige, // Light beige background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Congratulatory Text with fade-in animation
            FadeTransition(
              opacity: _textAnimationController,
              child: Column(
                children: [
                  Text(
                    "ممتاز!!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "جميع إجاباتك صحيحة. لقد حصلت على ${widget.earnedHearts} قلوب",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Check Icon with scale animation
            ScaleTransition(
              scale: CurvedAnimation(
                parent: _checkIconAnimationController,
                curve: Curves.elasticOut,
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: beige,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            SizedBox(height: 30),

            // Hearts with scale animation
            AnimatedBuilder(
              animation: _heartAnimationController,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.earnedHearts,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ScaleTransition(
                        scale: CurvedAnimation(
                          parent: _heartAnimationController,
                          curve: Interval(0.1 * index, 1.0, curve: Curves.easeOut),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 40),

            // Button with scaling effect on press
            AnimatedBuilder(
              animation: _buttonAnimationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _buttonAnimationController.value == 1
                      ? 1
                      : 0.95,
                  child: _buildButton(
                    context: context,
                    label: 'Continue',
                    color: brown,
                    onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/home'); 
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _buttonAnimationController.forward(from: 0);
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
