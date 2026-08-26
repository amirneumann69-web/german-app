import 'package:flutter/material.dart';

import '../design/design_system.dart';
import '../data/mock_data.dart';
import 'lesson_screen.dart';

class LevelScreen extends StatelessWidget {
  final Map<String, dynamic> level;

  const LevelScreen({
    super.key,
    required this.level,
  });

  // ==========================================================
  // GET LESSONS FOR LEVEL
  // ==========================================================

  List<Map<String, dynamic>> getLessonsForLevel(
    String levelId,
  ) {
    switch (levelId) {
      case 'A1':
        return mockA1Lessons;

      case 'A2':
        return mockA2Lessons;

      case 'B1':
        return mockB1Lessons;

      case 'B2':
        return mockB2Lessons;

      case 'C1':
        return mockC1Lessons;

      case 'C2':
        return mockC2Lessons;

      default:
        return <Map<String, dynamic>>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    final String levelId = level['id'] as String;

    final List<Map<String, dynamic>> lessons = getLessonsForLevel(levelId);

    final int levelColorValue = level['color'] as int;

    final Color levelColor = Color(levelColorValue);

    return Scaffold(
      backgroundColor: AppColors.background,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '$levelId · ${level['title']}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // LEVEL HEADER
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.borderLight,
                ),
              ),
              child: Row(
                children: [
                  // LEVEL ICON

                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: levelColor.withValues(
                        alpha: 0.10,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      levelId,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: levelColor,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // LEVEL INFORMATION

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          level['title'] ?? levelId,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          level['subtitle'] ?? '',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: _getProgress(levelId),
                            backgroundColor: AppColors.progressBackground,
                            color: levelColor,
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${(_getProgress(levelId) * 100).toInt()}% abgeschlossen',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ==================================================
            // LESSON TITLE
            // ==================================================

            Text(
              'Lektionen',
              style: AppTypography.sectionTitle,
            ),

            const SizedBox(height: 4),

            Text(
              'Tippe auf eine Lektion zum Lernen - einfach für alle',
              textDirection: TextDirection.rtl,
              style: AppTypography.persianSmall,
            ),

            const SizedBox(height: 14),

            // ==================================================
            // LESSON LIST
            // ==================================================

            if (lessons.isEmpty)
              _emptyLessonsMessage(levelId)
            else
              ...lessons.asMap().entries.map(
                (entry) {
                  final int index = entry.key;

                  final Map<String, dynamic> lesson = entry.value;

                  return _buildLessonCard(
                    context,
                    lesson,
                    index,
                    levelColor,
                  );
                },
              ),

            const SizedBox(height: 24),

            // ==================================================
            // EXTRA SECTIONS
            // ==================================================

            Text(
              'Mehr zum Lernen',
              style: AppTypography.sectionTitle.copyWith(fontSize: 16),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _extraCard(
                    Icons.auto_stories_outlined,
                    'Geschichten',
                    '15 Stories',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _extraCard(
                    Icons.quiz_outlined,
                    'Test',
                    '$levelId Test',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // LESSON CARD
  // ==========================================================

  Widget _buildLessonCard(
    BuildContext context,
    Map<String, dynamic> lesson,
    int index,
    Color levelColor,
  ) {
    final int lessonNumber = lesson['number'] as int;

    final String lessonId = lesson['id'] as String;

    final String titleDe =
        lesson['title_de']?.toString() ?? 'Lektion $lessonNumber';

    final String titleFa = lesson['title_fa']?.toString() ?? '';

    final String grammar = lesson['grammar']?.toString() ?? '';

    // First 8 A1 lessons are shown as completed
    // for the current demo progress.
    final bool isCompleted = lessonId.startsWith('a1_') && index < 8;

    final bool isCurrent = lessonId.startsWith('a1_') && index == 8;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCurrent ? AppColors.primary : AppColors.borderLight,
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LessonScreen(
                lessonMeta: lesson,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // =================================================
              // LESSON NUMBER
              // =================================================

              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: levelColor.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'L${lessonNumber.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: levelColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // =================================================
              // LESSON INFORMATION
              // =================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleDe,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (titleFa.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        titleFa,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    if (grammar.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        grammar,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 9,
                          color: levelColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // =================================================
              // STATUS
              // =================================================

              if (isCompleted)
                Container(
                  margin: const EdgeInsets.only(
                    right: 8,
                  ),
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY LEVEL
  // ==========================================================

  Widget _emptyLessonsMessage(
    String levelId,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.borderLight,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.menu_book_outlined,
            size: 40,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(
            '$levelId lessons coming soon',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PROGRESS
  // ==========================================================

  double _getProgress(
    String levelId,
  ) {
    switch (levelId) {
      case 'A1':
        return 0.68;

      case 'A2':
        return 1.0;

      case 'B1':
        return 0.07;

      default:
        return 0.0;
    }
  }

  // ==========================================================
  // EXTRA CARD
  // ==========================================================

  Widget _extraCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderLight,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
