import 'package:flutter/material.dart';

import '../design/design_system.dart';
import '../story_data/all_stories.dart';

class StoryReadingScreen extends StatefulWidget {
  final String storyId;

  const StoryReadingScreen({
    super.key,
    required this.storyId,
  });

  @override
  State<StoryReadingScreen> createState() => _StoryReadingScreenState();
}

class _StoryReadingScreenState extends State<StoryReadingScreen> {
  bool showPersian = false;
  bool showSummaryPersian = false;
  double fontSize = 17.0;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? story = allStoriesDatabase[widget.storyId];

    if (story == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Geschichte nicht gefunden'),
          backgroundColor: AppColors.background,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Story "${widget.storyId}" not found.\n\nDid you forget to add it to all_stories.dart?',
              textAlign: TextAlign.center,
              style: AppTypography.germanBody,
            ),
          ),
        ),
      );
    }

    final String titleDe = story['title_de'] as String? ??
        story['title'] as String? ??
        'Geschichte';
    final String titleFa = story['title_fa'] as String? ?? '';
    final String subtitleDe = story['subtitle_de'] as String? ?? '';
    final String levelId = story['level'] as String? ?? 'A2';
    final int number = story['number'] as int? ?? 1;
    final Color levelColor = _getLevelColor(levelId);

    final Map<String, dynamic>? recap =
        story['was_bisher_geschah'] as Map<String, dynamic>?;
    final Map<String, dynamic>? intro =
        story['introduction'] as Map<String, dynamic>?;
    final String storyDe = story['de'] as String? ?? '';
    final String storyFa = story['fa'] as String? ?? '';
    final List<dynamic> vocabList = story['vocab'] as List<dynamic>? ?? [];
    final Map<String, dynamic>? summary =
        story['zusammenfassung'] as Map<String, dynamic>?;

    final paragraphsDe =
        storyDe.split('\n\n').where((p) => p.trim().isNotEmpty).toList();
    final paragraphsFa =
        storyFa.split('\n\n').where((p) => p.trim().isNotEmpty).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$levelId · Geschichte $number',
              style:
                  AppTypography.caption.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              titleDe,
              style: AppTypography.cardTitle.copyWith(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.text_decrease,
              size: 20,
              color: AppColors.textSecondary,
            ),
            onPressed: () => setState(
              () => fontSize = (fontSize - 1).clamp(14.0, 22.0),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.text_increase,
              size: 20,
              color: AppColors.textSecondary,
            ),
            onPressed: () => setState(
              () => fontSize = (fontSize + 1).clamp(14.0, 22.0),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
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
                      const SizedBox(width: 8),
                      Text(
                        'Geschichte $number',
                        style: AppTypography.caption.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(titleDe, style: AppTypography.germanTitle),
                  if (titleFa.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      titleFa,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: AppTypography.persianBody,
                    ),
                  ],
                  if (subtitleDe.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      subtitleDe,
                      style: AppTypography.caption.copyWith(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Was Bisher Geschah
            if (recap != null) ...[
              SectionCard(
                title: 'Was bisher geschah',
                persianTitle: 'آنچه تاکنون گذشت',
                germanText: recap['de'] as String? ?? '',
                persianText: recap['fa'] as String? ?? '',
                icon: Icons.history_edu_outlined,
                backgroundColor: const Color(0xFFE3F2FD),
                borderColor: const Color(0xFFBBDEFB),
                fontSize: fontSize - 2,
              ),
              const SizedBox(height: 20),
            ],

            // Introduction
            if (intro != null) ...[
              SectionCard(
                title: 'Einleitung',
                persianTitle: 'مقدمه',
                germanText: intro['de'] as String? ?? '',
                persianText: intro['fa'] as String? ?? '',
                icon: Icons.info_outline,
                backgroundColor: const Color(0xFFFFF8E1),
                borderColor: const Color(0xFFFFE082),
                fontSize: fontSize - 2,
              ),
              const SizedBox(height: 20),
            ],

            // Main Story
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.menu_book,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Die Geschichte',
                        style: AppTypography.sectionTitle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...paragraphsDe.map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        p.trim(),
                        style: AppTypography.germanBody.copyWith(
                          fontSize: fontSize,
                          height: 1.7,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () => setState(
                        () => showPersian = !showPersian,
                      ),
                      icon: Icon(
                        showPersian ? Icons.visibility_off : Icons.translate,
                        size: 18,
                      ),
                      label: Text(
                        showPersian ? 'فارسی مخفی کن' : 'نمایش ترجمه فارسی',
                        style: const TextStyle(fontSize: 13),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),
                  if (showPersian) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFA5D6A7)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: paragraphsFa
                            .map(
                              (p) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  p.trim(),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: AppTypography.persianBody.copyWith(
                                    fontSize: (fontSize - 2).clamp(12.0, 20.0),
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Vocabulary
            if (vocabList.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.translate,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Wortschatz',
                          style: AppTypography.sectionTitle,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'واژگان',
                          textDirection: TextDirection.rtl,
                          style: AppTypography.persianSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...vocabList
                        .map((v) => VocabCard(data: v as Map<String, dynamic>)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Summary
            if (summary != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFFCC80)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.summarize,
                          size: 18,
                          color: Color(0xFFF57F17),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Zusammenfassung',
                          style: AppTypography.sectionTitle,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => setState(
                            () => showSummaryPersian = !showSummaryPersian,
                          ),
                          child: Text(
                            showSummaryPersian ? 'DE' : 'FA',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (!showSummaryPersian)
                      Text(
                        summary['de'] as String? ?? '',
                        style: AppTypography.germanBody.copyWith(
                          fontSize: fontSize - 2,
                        ),
                      )
                    else
                      Text(
                        summary['fa'] as String? ?? '',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: AppTypography.persianBody.copyWith(
                          fontSize: fontSize - 2,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ],
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

// Extracted Sub-widgets for better performance
class SectionCard extends StatelessWidget {
  final String title;
  final String persianTitle;
  final String germanText;
  final String persianText;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final double fontSize;

  const SectionCard({
    super.key,
    required this.title,
    required this.persianTitle,
    required this.germanText,
    required this.persianText,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(title, style: AppTypography.cardTitle),
              const Spacer(),
              Text(
                persianTitle,
                textDirection: TextDirection.rtl,
                style: AppTypography.persianSmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            germanText.trim(),
            style: AppTypography.germanBody.copyWith(fontSize: fontSize),
          ),
          if (persianText.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              persianText.trim(),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTypography.persianBody.copyWith(fontSize: fontSize - 1),
            ),
          ],
        ],
      ),
    );
  }
}

class VocabCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const VocabCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final String word = data['word']?.toString() ?? '';
    final String meaning = data['meaning']?.toString() ?? '';
    final String example = data['example']?.toString() ?? '';
    final String translation = data['translation']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  word,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                meaning,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (example.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    example,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (translation.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      translation,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
