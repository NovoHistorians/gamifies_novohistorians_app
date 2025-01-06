import 'package:flutter/material.dart';
import 'package:novo_historians/constants/colors.dart';
import 'package:novo_historians/data/chapters_data.dart';
import 'package:novo_historians/models/course_model.dart';
import 'package:novo_historians/screens/flashcard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/star_counter.dart';
import '../widgets/zigzag_card.dart';

class Courses extends StatefulWidget {
  final String chapterName;

  // Accept chapterName in the constructor
  Courses({required this.chapterName});

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  int totalStars = 0; // Start with 0 stars
  int totalHearts = 0; // Start with 0 hearts
  String badge = "مؤرخ مبتدئ"; // Default badge
  String level = "مستوى"; // Default level
  String year = '1'; // Default year
  List<Course> courses = []; // List to hold courses

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _loadCourses(); // Load courses for the chapter
  }

  // Load user preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      totalStars = prefs.getInt('totalStars') ?? 0;
      totalHearts = prefs.getInt('totalHearts') ?? 0;
      badge = prefs.getString('badge') ?? "مؤرخ مبتدئ";
      level = prefs.getString('level') ?? " 1 إب";
      year = prefs.getString('year') ?? " 1 إب";
    });

    _updateBadgeColor();
    level = getAbbreviation(level);
  }

  // Load courses for the chapter dynamically using the existing function
  Future<void> _loadCourses() async {
    List<Course> fetchedCourses =
        await getCoursesFromChapter(widget.chapterName);

    setState(() {
      courses = fetchedCourses;
    });
  }

  // Update badge color based on the number of stars
  void _updateBadgeColor() {
    if (totalStars >= 10) {
      badge = "مؤرخ ذهبي"; // Gold badge
    } else if (totalStars >= 5) {
      badge = "مؤرخ فضي"; // Silver badge
    } else {
      badge = "مؤرخ برونزي"; // Bronze badge
    }
  }

  // Check if a course is locked based on SharedPreferences
  // Check if a course is locked based on SharedPreferences
Future<bool> _isCourseLocked(String courseTitle) async {
  final prefs = await SharedPreferences.getInstance();

  // If the course is the first chapter, it's unlocked by default
  if (courses.isNotEmpty && courses.first.title == courseTitle) {
    return false;
  }

  // Otherwise, check the lock status from SharedPreferences
  return prefs.getBool('isLocked_$courseTitle') ?? true; // Default to locked
}


  // Unlock a course and save the status in SharedPreferences
  Future<void> _unlockCourse(String courseTitle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLocked_$courseTitle', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        backgroundColor: beige,
        title: StarCounter(
          totalStars: totalStars,
          totalHearts: totalHearts,
          badge: badge,
          level: level,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              // Display each course dynamically
              if (courses.isEmpty)
                Center(child: CircularProgressIndicator())
              else
                for (var course in courses) _buildCourseCard(course),
            ],
          ),
        ),
      ),
    );
  }

  // Build course card with lock/unlock logic
  Widget _buildCourseCard(Course course) {
    final starsRequired = course.starsRequired;
    final starsGranted = course.starsGranted;
    final courseTitle = course.title;

    return FutureBuilder<bool>(
      future: _isCourseLocked(courseTitle), // Check lock status dynamically
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final isLocked = snapshot.data!;
        final isCourseUnlocked = totalStars >= starsRequired;

        return GestureDetector(
          onTap: () async {
            if (isLocked) {
              if (totalStars >= starsRequired) {
                // Unlock the course and navigate
                await _unlockCourse(courseTitle);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlashcardPage(course: course),
                  ),
                );
              } else {
                // Show a dialog or message if the user doesn't have enough stars
                _showNotEnoughStarsDialog(context, starsRequired);
              }
            } else {
              // Navigate to the course if already unlocked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FlashcardPage(course: course),
                ),
              );
            }
          },
          child: ZigzagCard(
            number: courses.indexOf(course).toString(),
            stars: starsGranted,
            title: courseTitle,
            subtitle:
                isLocked ? "مقفل - تحتاج إلى $starsRequired نجوم" : "مفتوح",
            isLeft: courses.indexOf(course) % 2 == 0,
            isLocked:
                isLocked && !isCourseUnlocked, // Pass lock status to ZigzagCard
          ),
        );
      },
    );
  }

  // Show dialog if the user doesn't have enough stars
  void _showNotEnoughStarsDialog(BuildContext context, int starsRequired) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("ليس لديك نجوم كافية"),
          content: Text("تحتاج إلى $starsRequired نجوم لفتح هذه الدورة."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("موافق"),
            ),
          ],
        );
      },
    );
  }
}

// Helper function for abbreviation (placeholder, replace with your logic)
String getAbbreviation(String level) {
  return level.substring(0, level.indexOf(' ') + 1); // Example logic
}
