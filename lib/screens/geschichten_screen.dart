import 'package:flutter/material.dart';

import '../design/design_system.dart';
import '../story_data/all_stories.dart';
import 'story_reading_screen.dart';

// ============================================================
// GESCHICHTEN SCREEN
// ============================================================
// Shows all reading-only stories, grouped by level.
// Each level gets its own section with a colored header.
// Each story is shown as a card. Tapping a card opens
// StoryReadingScreen with that story's ID.
// ============================================================

class GeschichtenScreen extends StatelessWidget {
  const GeschichtenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levelsWithStories = getLevelsThatHaveStories();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Geschichten',
                style: AppTypography.germanTitle,
              ),
              const SizedBox(height: 8),
              Text(
                'داستان‌های کوتاه برای تمرین خواندن - بدون گرامر',
                textDirection: TextDirection.rtl,
                style: AppTypography.persianBody,
              ),
              const SizedBox(height: 8),
              Text(
                'Kurzgeschichten zum Lesen und Genießen. Keine Grammatik, keine Übungen - nur Geschichten.',
                style: AppTypography.caption,
              ),
              const SizedBox(height: 24),
              if (levelsWithStories.isEmpty)
                _buildEmptyState()
              else
                ...levelsWithStories.map(
                  (levelId) => _buildLevelSection(context, levelId),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.auto_stories_outlined,
            size: 72,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 20),
          Text(
            'بزودی داستان‌ها اضافه خواهند شد',
            textDirection: TextDirection.rtl,
            style: AppTypography.cardTitle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 12),
          Text(
            'در حال حاضر داستانی برای نمایش وجود ندارد.',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: AppTypography.persianBody,
          ),
        ],
      ),
    );
  }

  Widget _buildLevelSection(BuildContext context, String levelId) {
    final stories = getStoriesForLevel(levelId);
    final levelColor = _getLevelColor(levelId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: levelColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                levelId,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${stories.length} ${stories.length == 1 ? "Geschichte" : "Geschichten"}',
              style: AppTypography.cardTitle,
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...stories.map(
          (story) => _buildStoryCard(context, story, levelColor),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildStoryCard(
    BuildContext context,
    Map<String, dynamic> story,
    Color levelColor,
  ) {
    final String storyId = story['id'] as String;
    final int number = story['number'] as int;
    final String titleDe =
        story['title_de'] as String? ?? story['title'] ?? 'Geschichte';
    final String titleFa = story['title_fa'] as String? ?? '';
    final String subtitleDe = story['subtitle_de'] as String? ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StoryReadingScreen(storyId: storyId),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: levelColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'S${number.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: levelColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 14),
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
                    if (subtitleDe.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitleDe,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: levelColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
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

  Color _getLevelColor(String levelId) {
    switch (levelId) {
      case 'A1':
        return const Color(0xFF4CAF50);
      case 'A2':
        return const Color(0xFF2196F3);
      case 'B1':
        return const Color(0xFFFF9800);
      case 'B2':
        return const Color(0xFFE91E63);
      case 'C1':
        return const Color(0xFF9C27B0);
      case 'C2':
        return const Color(0xFF607D8B);
      default:
        return AppColors.primary;
    }
  }
}
