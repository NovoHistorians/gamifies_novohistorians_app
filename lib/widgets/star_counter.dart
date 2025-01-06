import 'package:flutter/material.dart';
import 'package:novo_historians/constants/colors.dart';

class StarCounter extends StatelessWidget {
  final int totalStars;
  final int totalHearts;
  final String badge;
  final String level;

  const StarCounter({
    required this.totalStars,
    required this.totalHearts,
    required this.badge,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    
    Color badgeColor;
    switch (badge) {
      case "مؤرخ ذهبي": // Gold badge
        badgeColor = Colors.amber; // Set a gold color
        break;
      case "مؤرخ فضي": // Silver badge
        badgeColor = Colors.grey; // Set a silver color
        break;
      case "مؤرخ برونزي": // Bronze badge
        badgeColor = Colors.brown; // Set a bronze color
        break;
      default:
        badgeColor = Colors.grey; // Default color if badge is not recognized
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Badge Icon and Label
        Row(
          children: [
            Icon(Icons.emoji_events, color: badgeColor, size: 29), // Use dynamic badge color
            SizedBox(width: 4),
            Text(
              badge,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(width: 16),
        // Hearts Icon and Count
        Row(
          children: [
            Icon(Icons.favorite, color: Colors.red, size: 29),
            SizedBox(width: 4),
            Text(
              totalHearts.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(width: 16),
        // Stars Icon and Count
        Row(
          children: [
            Icon(Icons.star, color: Colors.blueAccent, size: 30),
            SizedBox(width: 4),
            Text(
              totalStars.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(width: 16),
        // Level
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: lightbrown,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            level,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
