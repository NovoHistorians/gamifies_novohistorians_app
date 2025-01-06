import 'package:flutter/material.dart';
import 'package:novo_historians/constants/colors.dart';

class ZigzagCard extends StatelessWidget {
  final String number;
  final int stars;
  final String title;
  final String subtitle;
  final bool isLeft;
  final bool isLocked;

  const ZigzagCard({
    required this.number,
    required this.stars,
    required this.title,
    required this.subtitle,
    required this.isLeft,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    // Set the color based on whether the card is locked
    final cardColor = isLocked ? Colors.grey[300] : Colors.white; // Grey if locked
    final textColor = isLocked ? Colors.grey : Colors.black; // Grey text if locked
    final starColor = isLocked ? Colors.grey : Colors.blueAccent; // Grey stars if locked

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16), // Reduced padding
      child: Row(
        mainAxisAlignment: isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              _buildCardContent(cardColor!, textColor), // Pass color to content
              _buildCardHeader(cardColor), // Pass color to header
              _buildFloatingStars(starColor), // Pass star color for floating effect
            ],
          ),
        ],
      ),
    );
  }

  // Builds the card content with dynamic color
  Widget _buildCardContent(Color cardColor, Color textColor) {
    return Container(
      width: 180, // Reduced width
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10), // Reduced padding
      margin: EdgeInsets.symmetric(horizontal: 12), // Reduced margin
      decoration: BoxDecoration(
        color: cardColor, // Set the background color dynamically
        borderRadius: BorderRadius.circular(12), // Reduced border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5, // Reduced blur radius
            offset: Offset(0, 3), // Slightly smaller shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 32), // Reduced height
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12, // Reduced font size
              fontWeight: FontWeight.bold,
              color: textColor, // Set the text color dynamically
            ),
          ),
          SizedBox(height: 6), // Reduced spacing
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10, // Reduced font size
              color: textColor, // Set subtitle color dynamically
            ),
          ),
        ],
      ),
    );
  }

  // Builds the card header with dynamic color
  Widget _buildCardHeader(Color cardColor) {
    return Positioned(
      top: -16, // Adjusted position
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: cardColor == Colors.grey[300] ? Colors.grey : brown, // Grey if locked
          borderRadius: BorderRadius.circular(6), // Reduced border radius
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: 16, // Reduced font size
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Floating stars with animation
  Widget _buildFloatingStars(Color starColor) {
    return Positioned(
      top: -30, // Adjusted position
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: -10), 
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut, 
        builder: (context, double value, child) {
          return Transform.translate(
            offset: Offset(0, value), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                stars,
                (index) => Icon(
                  Icons.star,
                  color: starColor, 
                  size: 14, 
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
