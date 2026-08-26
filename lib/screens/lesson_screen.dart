import 'package:flutter/material.dart';
import '../lesson_data/all_lessons.dart';

class LessonScreen extends StatefulWidget {
  final Map<String, dynamic> lessonMeta;
  const LessonScreen({super.key, required this.lessonMeta});
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  bool showTranslation = false;
  bool showPreviouslyTranslation = false;

  Widget persian(String t, {bool bold = false}) => Text(t, textDirection: TextDirection.rtl, style: TextStyle(height: 1.9, fontSize: 14, fontWeight: bold ? FontWeight.bold : FontWeight.normal));
  Widget german(String t) => Container(width: double.infinity, margin: const EdgeInsets.symmetric(vertical: 6), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.indigo.shade100)), child: Text(t, textDirection: TextDirection.ltr, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, height: 1.6)));

  @override
  Widget build(BuildContext context) {
    final id = widget.lessonMeta['id'];
    final data = allLessonsDatabase[id];

    if (data == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Lesson ${widget.lessonMeta['number']}')),
        body: Center(child: Text('Lesson $id not found. Did you add it to all_lessons.dart?')),
      );
    }

    final vocabList = data['vocab'] as List;
    final grammarList = data['grammar'] as List;
    final hasPreviously = data.containsKey('previously');

    return Scaffold(
      appBar: AppBar(title: Text('Lektion ${widget.lessonMeta['number']}: ${data['title']}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Previously section for A2+ (recap)
            if (hasPreviously) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Was bisher geschah... / آنچه تاکنون گذشت...', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 8),
                    Text(data['previously']['de'], style: const TextStyle(fontSize: 14, height: 1.6, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () => setState(() => showPreviouslyTranslation = !showPreviouslyTranslation),
                        child: Text(showPreviouslyTranslation ? 'Hide Recap Translation' : 'Show Recap Translation'),
                      ),
                    ),
                    if (showPreviouslyTranslation)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                        child: Text(data['previously']['fa'], textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 13, height: 1.6)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
            ],

            // Story German
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
              child: Text(data['de'], style: const TextStyle(fontSize: 16, height: 1.7)),
            ),
            const SizedBox(height: 12),
            // Hidden Translation Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () => setState(() => showTranslation = !showTranslation),
                icon: Icon(showTranslation ? Icons.visibility_off : Icons.visibility),
                label: Text(showTranslation ? 'Hide Translation' : 'Show Persian Translation'),
              ),
            ),
            if (showTranslation)
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)),
                child: Text(data['fa'], textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 14, height: 1.8)),
              ),

            const Divider(height: 32),
            // Vocabulary - supports both formats
            const Text('Wortschatz / واژگان:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            ...vocabList.map((v) {
              if (v.containsKey('word')) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(v['word'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                            const SizedBox(width: 12),
                            Text(v['meaning'], style: const TextStyle(color: Colors.indigo, fontSize: 13)),
                          ],
                        ),
                        if (v['example'] != null) ...[
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(v['example'], textDirection: TextDirection.ltr, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                if (v['translation'] != null) ...[
                                  const SizedBox(height: 4),
                                  Text(v['translation'], textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              } else {
                return Card(
                  child: ListTile(
                    title: Text(v['de'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(v['fa'], style: const TextStyle(color: Colors.indigo)),
                  ),
                );
              }
            }),

            const Divider(height: 32),
            // Grammar
            Text('Grammatik / گرامر - Lektion ${widget.lessonMeta['number']}:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var section in grammarList)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (section.containsKey('topic')) ...[
                          persian(section['topic'], bold: true),
                          const SizedBox(height: 6),
                          if (section['explanation'] != null) persian(section['explanation']),
                          const SizedBox(height: 8),
                          if (section['examples'] != null)
                            for (var ex in section['examples'])
                              Padding(padding: const EdgeInsets.only(bottom: 6), child: german(ex)),
                        ] else ...[
                          if (section['title'] != null && section['title'].toString().isNotEmpty)
                            persian(section['title'], bold: true),
                          if (section['fa'] != null && section['fa'].toString().isNotEmpty)
                            Padding(padding: const EdgeInsets.only(top: 6, bottom: 4), child: persian(section['fa'])),
                          if (section['de'] != null && section['de'].toString().isNotEmpty)
                            german(section['de']),
                          if (section['fa2'] != null && section['fa2'].toString().isNotEmpty)
                            Padding(padding: const EdgeInsets.only(top: 6), child: persian(section['fa2'])),
                        ],
                        const Divider(height: 24),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
