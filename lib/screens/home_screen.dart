import 'package:flutter/material.dart';

import '../design/design_system.dart';
import '../data/mock_data.dart';
import 'level_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // GREETING
              // ==================================================

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hallo, Amir',
                          style: AppTypography.germanTitle.copyWith(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bereit für deine nächste Lektion?',
                          textDirection: TextDirection.rtl,
                          style: AppTypography.persianBody.copyWith(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ==================================================
              // A1 PROGRESS CARD
              // ==================================================

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.borderLight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'A1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Deutsch lernen - Anfänger',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          '68%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.68,
                        backgroundColor: AppColors.progressBackground,
                        color: AppColors.primary,
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '8 von 12 Lektionen',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '5 Tage Streak 🔥',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ==================================================
              // LEVELS TITLE
              // ==================================================

              Text(
                'Deine Levels',
                style: AppTypography.sectionTitle.copyWith(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Alle Lektionen mit Bildern - einfach und für alle verständlich',
                textDirection: TextDirection.rtl,
                style: AppTypography.persianSmall,
              ),

              const SizedBox(height: 16),

              // ==================================================
              // LEVEL CARDS
              // ==================================================

              ...levels.map(
                (level) {
                  return _buildLevelCard(
                    context,
                    level,
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // ========================================================
      // BOTTOM NAVIGATION
      // ========================================================

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: AppColors.borderLight,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(
                  Icons.school,
                  'Lernen',
                  true,
                ),
                _navItem(
                  Icons.auto_stories,
                  'Geschichten',
                  false,
                ),
                _navItem(
                  Icons.quiz_outlined,
                  'Übungen',
                  false,
                ),
                _navItem(
                  Icons.show_chart,
                  'Fortschritt',
                  false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // LEVEL CARD
  // ==========================================================

  Widget _buildLevelCard(
    BuildContext context,
    Map<String, dynamic> level,
  ) {
    final int colorValue = level['color'] as int;

    final Color levelColor = Color(colorValue);

    final String levelId = level['id'] as String;

    final int lessonCount = level['lessonCount'] as int;

    final double progress = _getProgress(levelId);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LevelScreen(
                level: level,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // LEVEL BADGE

              Container(
                width: 64,
                height: 64,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: levelColor,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // LEVEL INFORMATION

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level['title'] ?? levelId,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: AppColors.progressBackground,
                              color: levelColor,
                              minHeight: 5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: levelColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$lessonCount Lektionen',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // PROGRESS
  // ==========================================================

  double _getProgress(String levelId) {
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
  // BOTTOM NAV ITEM
  // ==========================================================

  Widget _navItem(
    IconData icon,
    String label,
    bool active,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: active ? AppColors.primary : Colors.grey,
          size: 22,
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            color: active ? AppColors.primary : Colors.grey,
          ),
        ),
      ],
    );
  }
}
