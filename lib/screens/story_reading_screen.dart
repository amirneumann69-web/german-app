import 'package:flutter/material.dart';
import '../design/design_system.dart';

class StoryReadingScreen extends StatefulWidget {
  const StoryReadingScreen({super.key});

  @override
  State<StoryReadingScreen> createState() => _StoryReadingScreenState();
}

class _StoryReadingScreenState extends State<StoryReadingScreen> {
  bool showPersian = false;
  double fontSize = 17;
  String? selectedWord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A1 · Lesegeschichte 07',
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Der Sonntag im kleinen Café',
              style: AppTypography.cardTitle.copyWith(fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress
          LinearProgressIndicator(
            value: 0.35,
            backgroundColor: AppColors.progressBackground,
            color: AppColors.primary,
            minHeight: 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta
                  Row(
                    children: [
                      const LevelBadge(level: 'A1'),
                      const SizedBox(width: 8),
                      Text(
                        '5 Min. • 220 Wörter',
                        style: AppTypography.caption,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.text_decrease, size: 20),
                        onPressed: () => setState(() {
                          fontSize = (fontSize - 1).clamp(14, 22);
                        }),
                      ),
                      IconButton(
                        icon: const Icon(Icons.text_increase, size: 20),
                        onPressed: () => setState(() {
                          fontSize = (fontSize + 1).clamp(14, 22);
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Hero Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      color: AppColors.surfaceSecondary,
                      child: Image.network(
                        'https://images.unsplash.com/photo-1445116572660-236099ec97a0?w=800',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // German Story Text
                  _buildParagraph(
                    'Es ist Sonntagnachmittag. Draußen regnet es. Emma ist zu Hause und findet die Zeit lang. Sie geht auf den Dachboden.',
                    fontSize,
                  ),
                  const SizedBox(height: 16),
                  _buildParagraph(
                    'In der Ecke sieht Emma eine kleine Holzkiste. Sie ist braun und alt. Emma öffnet die Kiste.',
                    fontSize,
                  ),
                  const SizedBox(height: 16),
                  _buildParagraphWithTappableWord(
                    'In der Kiste liegt ein Buch. Es ist ein Tagebuch. Auf der ersten Seite steht ein Datum: "Am 14. August 1975".',
                    'Tagebuch',
                    fontSize,
                  ),
                  const SizedBox(height: 16),
                  _buildParagraph(
                    'Emma setzt sich auf den Boden und liest. "Heute war ein besonderer Tag", schreibt jemand. "Ich habe morgens im Garten gearbeitet. Dann habe ich meine Freundin Rita besucht."',
                    fontSize,
                  ),

                  const SizedBox(height: 16),

                  // Persian Translation Toggle
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () => setState(() {
                        showPersian = !showPersian;
                      }),
                      icon: Icon(
                        showPersian ? Icons.visibility_off : Icons.translate,
                        size: 18,
                      ),
                      label: Text(
                        showPersian ? 'فارسی مخفی کن' : 'فارسی نمایش بده',
                        style: const TextStyle(fontSize: 13),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        side: BorderSide(color: AppColors.borderLight),
                      ),
                    ),
                  ),

                  if (showPersian) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFA5D6A7)),
                      ),
                      child: Text(
                        'یکشنبه بعدازظهر است. بیرون باران می‌بارد. اِما در خانه است و زمان برایش طولانی می‌گذرد. او به اتاق زیر شیروانی می‌رود.',
                        textDirection: TextDirection.rtl,
                        style: AppTypography.persianBody.copyWith(
                          fontSize: fontSize - 2,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Word Popup Example
                  if (selectedWord != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  selectedWord!,
                                  style: AppTypography.cardTitle.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.volume_up_outlined,
                                    size: 20),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.favorite_border, size: 20),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Text(
                            'der Schlüssel, die Schlüssel',
                            style: AppTypography.caption.copyWith(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'کلید',
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSecondary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Der Schlüssel liegt auf dem Boden.',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'کلید روی زمین افتاده است.',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Bottom Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: AppColors.borderLight),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Zurück'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Geschichte abgeschlossen'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraph(String text, double fontSize) {
    return Text(
      text,
      style: AppTypography.germanBody.copyWith(fontSize: fontSize),
    );
  }

  Widget _buildParagraphWithTappableWord(
    String paragraph,
    String tappableWord,
    double fontSize,
  ) {
    final parts = paragraph.split(tappableWord);
    return RichText(
      text: TextSpan(
        style: AppTypography.germanBody.copyWith(fontSize: fontSize),
        children: [
          TextSpan(text: parts[0]),
          WidgetSpan(
            child: GestureDetector(
              onTap: () => setState(() {
                selectedWord = tappableWord;
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(4),
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.accent,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  tappableWord,
                  style: AppTypography.germanBody.copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }
}
