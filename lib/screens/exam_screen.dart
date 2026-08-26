import 'package:flutter/material.dart';
import '../exam_data/all_exams.dart';

class ExamScreen extends StatefulWidget {
  final String levelId;
  const ExamScreen({super.key, required this.levelId});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late Map<String, dynamic> exam;
  int? selectedPartIndex; // null = overview, 0,1,2 = inside a part
  int currentQuestionIndex = 0;
  Map<int, Map<int, String>> partAnswers =
      {}; // partIndex -> {questionIndex -> selectedOption}
  Map<int, Map<int, bool>> partCorrect =
      {}; // partIndex -> {questionIndex -> wasCorrect}
  Map<int, int> partScores = {}; // partIndex -> score

  @override
  void initState() {
    super.initState();
    exam = allExamsDatabase[widget.levelId]!;
  }

  List<Map<String, dynamic>> getQuestionsForPart(int partIndex) {
    return (exam['parts'][partIndex]['questions'] as List)
        .cast<Map<String, dynamic>>();
  }

  void startPart(int partIndex) {
    setState(() {
      selectedPartIndex = partIndex;
      currentQuestionIndex = 0;
    });
  }

  void backToOverview() {
    setState(() {
      selectedPartIndex = null;
      currentQuestionIndex = 0;
    });
  }

  Map<String, dynamic> getCurrentQuestion() {
    return getQuestionsForPart(selectedPartIndex!)[currentQuestionIndex];
  }

  bool isQuestionAnswered(int partIdx, int qIdx) {
    return partAnswers[partIdx]?.containsKey(qIdx) ?? false;
  }

  void answerQuestion(String option) {
    final partIdx = selectedPartIndex!;
    final q = getCurrentQuestion();
    String correctAnswer = q['answer'];
    bool correct = false;

    if (correctAnswer.length == 1 && RegExp(r'[A-D]').hasMatch(correctAnswer)) {
      int correctIdx = correctAnswer.codeUnitAt(0) - 65;
      if (correctIdx >= 0 && correctIdx < (q['options'] as List).length) {
        String correctOptionText = q['options'][correctIdx];
        correct = option == correctOptionText;
      }
    } else {
      correct = option.toString().trim().toLowerCase() ==
              correctAnswer.toString().trim().toLowerCase() ||
          option == q['answerText'];
    }

    setState(() {
      partAnswers.putIfAbsent(partIdx, () => {})[currentQuestionIndex] = option;
      partCorrect.putIfAbsent(partIdx, () => {})[currentQuestionIndex] =
          correct;
      // Recalculate score for this part
      int score = 0;
      partCorrect[partIdx]!.forEach((_, isCorr) {
        if (isCorr) score++;
      });
      partScores[partIdx] = score;
    });
  }

  void nextQuestionInPart() {
    final questions = getQuestionsForPart(selectedPartIndex!);
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // End of part - show part result and go back to overview
      showPartResult();
    }
  }

  void previousQuestionInPart() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void showPartResult() {
    final partIdx = selectedPartIndex!;
    final part = exam['parts'][partIdx];
    final score = partScores[partIdx] ?? 0;
    final total = (part['questions'] as List).length;
    final isLastPart = partIdx == (exam['parts'] as List).length - 1;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('${part['title']} - Ergebnis'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(score >= total * 0.6 ? Icons.emoji_events : Icons.info,
                size: 50,
                color: score >= total * 0.6 ? Colors.green : Colors.orange),
            const SizedBox(height: 12),
            Text('Dein Ergebnis für ${part['title']}:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('$score / $total Punkte',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
                value: score / total,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                    score >= total * 0.6 ? Colors.green : Colors.orange)),
            const SizedBox(height: 12),
            Text(score >= total * 0.6
                ? 'Super gemacht!'
                : 'Noch ein bisschen üben!'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                backToOverview();
              },
              child: const Text('Zur Übersicht')),
          if (!isLastPart)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Go to next part overview - user can click next part if they want
                backToOverview();
                // Auto-select next part? No, let user decide - as requested: clickable Grammatik/Lesen
              },
              child: Text(isLastPart ? 'Fertig' : 'Weiter zur Übersicht'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // OVERVIEW SCREEN - shows 3 parts separated, clickable
    if (selectedPartIndex == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(exam['title']),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < (exam['parts'] as List).length; i++)
                _buildPartCard(i),
              const SizedBox(height: 20),
              // Total score
              if (partScores.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Gesamt bisher:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          '${partScores.values.fold(0, (a, b) => a + b)} / ${exam['totalQuestions']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // INSIDE A PART - show questions numbered
    final part = exam['parts'][selectedPartIndex!];
    final questions = getQuestionsForPart(selectedPartIndex!);
    final q = questions[currentQuestionIndex];
    final partScore = partScores[selectedPartIndex!] ?? 0;
    final isAnswered =
        isQuestionAnswered(selectedPartIndex!, currentQuestionIndex);
    final selectedOption =
        partAnswers[selectedPartIndex!]?[currentQuestionIndex];
    final isCorrect =
        partCorrect[selectedPartIndex!]?[currentQuestionIndex] ?? false;
    final overallIndex = currentQuestionIndex + 1;
    final totalInPart = questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${part['title']} - Frage $overallIndex/$totalInPart'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), onPressed: backToOverview),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
                value: overallIndex / totalInPart,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple)),
            const SizedBox(height: 12),
            Text(
                '${part['title']} - Frage $overallIndex von $totalInPart (Nummeriert)',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 12),
            if (q['text'] != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(q['text'],
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ),
            if (q['text'] != null) const SizedBox(height: 12),
            // Numbered question
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text('${q['id']}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: Text(q['question'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 16),
            if (q['wordBank'] != null)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8)),
                child: Text('Wörter: ${q['wordBank']}',
                    style: const TextStyle(fontSize: 12)),
              ),
            if (q['wordBank'] != null) const SizedBox(height: 12),
            ...(q['options'] as List).map((opt) {
              Color? tileColor;
              if (isAnswered) {
                if (opt == selectedOption) {
                  tileColor =
                      isCorrect ? Colors.green.shade100 : Colors.red.shade100;
                } else if (opt == q['answerText'] ||
                    (q['answer'].toString().length == 1 &&
                        q['options'].indexOf(opt) ==
                            q['answer'].codeUnitAt(0) - 65)) {
                  tileColor = Colors.green.shade50;
                }
              }
              return Card(
                color: tileColor,
                child: ListTile(
                  leading: Text(
                      '${String.fromCharCode(65 + (q['options'] as List).indexOf(opt))}.',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: Text(opt),
                  trailing: isAnswered && opt == selectedOption
                      ? Icon(isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green : Colors.red)
                      : null,
                  onTap: isAnswered ? null : () => answerQuestion(opt),
                ),
              );
            }),
            const SizedBox(height: 16),
            if (isAnswered)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: isCorrect ? Colors.green : Colors.red),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        isCorrect
                            ? '✅ Richtig! Frage ${q['id']}'
                            : '❌ Falsch. Frage ${q['id']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isCorrect
                                ? Colors.green.shade800
                                : Colors.red.shade800)),
                    const SizedBox(height: 8),
                    Text(
                        'Richtige Antwort: ${q['answer']}) ${q['answerText'] ?? q['answer']}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (q['explanation_de'] != null) ...[
                      const SizedBox(height: 4),
                      Text('Erklärung: ${q['explanation_de']}'),
                    ],
                    if (q['explanation_fa'] != null) ...[
                      const SizedBox(height: 4),
                      Text('توضیح: ${q['explanation_fa']}',
                          textDirection: TextDirection.rtl),
                    ],
                    if (q['example'] != null) ...[
                      const SizedBox(height: 4),
                      Text('Beispiel: ${q['example']}',
                          style: const TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: currentQuestionIndex == 0
                        ? null
                        : () => setState(() => currentQuestionIndex--),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Zurück'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: !isAnswered
                        ? null
                        : () {
                            if (currentQuestionIndex < totalInPart - 1) {
                              setState(() => currentQuestionIndex++);
                            } else {
                              // End of part
                              final score = partScores[selectedPartIndex!] ?? 0;
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => AlertDialog(
                                  title: Text('${part['title']} - Fertig!'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Ergebnis ${part['title']}:',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      Text('$score / $totalInPart Punkte',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      LinearProgressIndicator(
                                          value: score / totalInPart,
                                          backgroundColor: Colors.grey.shade300,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  score >= totalInPart * 0.6
                                                      ? Colors.green
                                                      : Colors.orange)),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          backToOverview();
                                        },
                                        child: const Text(
                                            'Zur Übersicht - Pause?')),
                                  ],
                                ),
                              );
                            }
                          },
                    icon: Icon(currentQuestionIndex == totalInPart - 1
                        ? Icons.flag
                        : Icons.arrow_forward),
                    label: Text(currentQuestionIndex == totalInPart - 1
                        ? 'Fertig - Ergebnis'
                        : 'Weiter'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Center(
                child: Text(
                    'Teil-Punkte: $partScore / $totalInPart | Gesamt: ${partScores.values.fold(0, (a, b) => a + b)}/${getAllQuestionsInExam()}',
                    style: const TextStyle(color: Colors.grey, fontSize: 11))),
          ],
        ),
      ),
    );
  }

  int getAllQuestionsInExam() {
    return (exam['parts'] as List)
        .fold(0, (sum, p) => sum + (p['questions'] as List).length);
  }

  Widget _buildPartCard(int partIndex) {
    final part = exam['parts'][partIndex];
    final questions = part['questions'] as List;
    final isCompleted = partScores.containsKey(partIndex);
    final score = partScores[partIndex] ?? 0;
    final total = questions.length;

    // All parts active at same time - learners can choose any order (as requested)
    bool canClick = true;

    return Card(
      // ignore: dead_code
      color: isCompleted
          ? Colors.green.shade50
          // ignore: dead_code
          : (canClick ? Colors.white : Colors.grey.shade100),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          // ignore: dead_code
          backgroundColor: isCompleted
              ? Colors.green
              // ignore: dead_code
              : (canClick ? Colors.deepPurple : Colors.grey),
          child: isCompleted
              ? const Icon(Icons.check, color: Colors.white)
              : Text('${partIndex + 1}',
                  style: const TextStyle(color: Colors.white)),
        ),
        // ignore: dead_code
        title: Text(part['title'],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                // ignore: dead_code
                color: canClick ? Colors.black : Colors.grey)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${part['points']} Punkte - ${total} Fragen',
                style: const TextStyle(fontSize: 12)),
            if (isCompleted)
              Text('Ergebnis: $score / $total',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: Colors.deepPurple),
        // ignore: dead_code
        onTap: canClick ? () => startPart(partIndex) : null,
      ),
    );
  }
}
