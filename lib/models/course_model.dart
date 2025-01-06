import 'package:flutter/material.dart';

import '../screens/flashcard_screen.dart';
import '../services/notification_service.dart';
import '../widgets/study_tracker.dart';
import 'quiz_model.dart';

class Course {
  final String number;
  final String title;

  final String content;
  final Quiz quiz;
  int starsRequired; 
  int starsGranted;
  int heartsGranted;

  Course({
    required this.number,
    required this.title,
    this.content = '',
    required this.quiz,
    this.starsRequired = 0, 
    this.starsGranted = 0,
    this.heartsGranted = 0, 
  });
}
