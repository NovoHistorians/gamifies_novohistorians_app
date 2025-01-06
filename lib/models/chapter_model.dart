import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:novo_historians/screens/courses.dart';
import 'course_model.dart';

class Chapter {
  final String number;
  final String title;
  final List<Course> courses;
  final String backgroundImage;
  final int heartsRequired;

  Chapter({
    required this.number,
    required this.title,
    required this.courses,
    required this.backgroundImage,
    required this.heartsRequired,
  });
}

class ChapterCard extends StatefulWidget {
  final Chapter chapter;

  ChapterCard({required this.chapter});

  @override
  _ChapterCardState createState() => _ChapterCardState();
}

class _ChapterCardState extends State<ChapterCard> {
  int totalStars = 0;

  @override
  void initState() {
    super.initState();
    _loadTotalStars();
  }

  Future<void> _loadTotalStars() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalStars = prefs.getInt('totalStars') ?? 0;
    });
  }

  void _showLockedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "الفصل مغلق",
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "تحتاج إلى ${widget.chapter.heartsRequired} قلوب لفتح هذا الفصل.",
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق النافذة المنبثقة
              },
              child: Text("حسناً"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int completedCourses = 0;
    int totalCourses = widget.chapter.courses.length;

    bool isLocked = totalStars < widget.chapter.heartsRequired;

    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.chapter.backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الجزء الأيسر
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$completedCourses/$totalCourses',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // الجزء الأيمن
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.chapter.number}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Text(
                        widget.chapter.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        ),
                      ),
                      SizedBox(height: 25),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: isLocked
                                ? () {
                                    _showLockedDialog(context); //
                                  }
                                : () {
                                    //
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Courses(
                                          chapterName: widget.chapter.title,
                                        ),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              isLocked ? 'مغلق' : 'قراءة الدروس',
                              style: TextStyle(
                                color:
                                    isLocked ? Colors.grey : Color(0xFF000000),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (isLocked)
                            Positioned(
                              right: 3,
                              top: 8,
                              child: Icon(
                                Icons.lock,
                                color: Colors.red,
                                size: 24,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
