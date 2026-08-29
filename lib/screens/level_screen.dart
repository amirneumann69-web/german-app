import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import 'lesson_screen.dart';
import 'exam_screen.dart';

class LevelScreen extends StatelessWidget {
  final Map<String, dynamic> level;
  const LevelScreen({super.key, required this.level});

  List<Map<String, dynamic>> getLessonsForLevel(String levelId) {
    switch (levelId) {
      case 'A1':
        return mockA1Lessons;
      case 'A2':
        return mockA2Lessons;
      case 'B1':
        return mockB1Lessons;
      case 'B2': // ✅ ADDED
        return mockB2Lessons; // ✅ ADDED
      default:
        return mockA1Lessons;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessons = getLessonsForLevel(level['id']);

    return Scaffold(
      appBar: AppBar(
        title: Text(level['title']),
        backgroundColor: Color(level['color']),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade50,
            child: const Text(
              'Testing Mode: All lessons clickable.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.green),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lessons.length + 1,
              itemBuilder: (context, index) {
                if (index == lessons.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Card(
                      color: Colors.deepPurple.shade50,
                      child: ListTile(
                        leading:
                            const Icon(Icons.quiz, color: Colors.deepPurple),
                        title: Text('${level['id']} Abschlussprüfung',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Teste dein Wissen - ${level['id']}'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ExamScreen(
                                    levelId: level['id'].toLowerCase())),
                          );
                        },
                      ),
                    ),
                  );
                }
                final lesson = lessons[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${lesson['number']}')),
                    title:
                        Text('${lesson['title_fa']} - ${lesson['title_de']}'),
                    subtitle: Text('Grammar: ${lesson['grammar']}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LessonScreen(lessonMeta: lesson)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
