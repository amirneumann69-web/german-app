# Anleitung: Wie du Test/Quiz in jedes Level einbaust

Nach unserem sicheren System (separate Dateien, alte Lektionen brechen nie) geht das so:

## ARCHITEKTUR für Prüfungen:

```
lib/
├── lesson_data/          <- Alle Lektionen (A1, A2...)
│   ├── a1_l01_data.dart
│   └── ...
├── exam_data/            <- NEU: Alle Prüfungen (A1, A2...)
│   ├── a1_abschlusspruefung.dart  <- Deine A1 Prüfung (30+25+10 Fragen)
│   ├── a2_abschlusspruefung.dart  <- Später
│   └── all_exams.dart    <- Registry wie bei all_lessons.dart
├── screens/
│   ├── level_screen.dart (hat Button "Abschlussprüfung")
│   ├── lesson_screen.dart
│   └── exam_screen.dart  <- NEU: Zeigt Fragen, Feedback, Punkte
```

## SCHRITT-FÜR-SCHRITT:

### Schritt 1: Ordner erstellen
In VS Code:
- Rechtsklick auf `lib` -> New Folder -> `exam_data`

### Schritt 2: Prüfungsdatei erstellen
- In `lib/exam_data/` -> New File -> `a1_abschlusspruefung.dart`
- Inhalt: Die komplette Prüfung mit 60 Fragen (Teil 1 Wortschatz 30, Teil 2 Grammatik 25, Teil 3 Lesen 10)
- Format: Map mit id, question, options, answer, explanation_de, explanation_fa, example

### Schritt 3: Registry erstellen
- In `lib/exam_data/` -> New File -> `all_exams.dart`
- Inhalt:
```dart
import 'a1_abschlusspruefung.dart';
final Map<String, Map<String, dynamic>> allExamsDatabase = {
  'a1': a1_abschlusspruefung,
  'a2': a2_abschlusspruefung, // später
};
```

### Schritt 4: Exam Screen erstellen
- In `lib/screens/` -> New File -> `exam_screen.dart`
- Dieser Screen:
  - Lädt Prüfung aus allExamsDatabase[levelId]
  - Zeigt Frage für Frage
  - Bei Antwort: Zeigt Feedback wie in deinem Beispiel:
    ✅ Richtig! Bäckerei = نانوایی + Beispiel
    ❌ Falsch. Richtige Antwort: B) In der Bäckerei + Erklärung auf Persisch
  - Zählt Punkte (30 + 25 + 10 = 65? Bei dir 30 Punkte Teil 1, aber 60 Fragen total)
  - Am Ende: Ergebnis + Bestanden/Nicht bestanden

### Schritt 5: Button in Level Screen einbauen
- Öffne `lib/screens/level_screen.dart`
- Unter der ListView der Lektionen, füge einen Button hinzu:
```dart
ElevatedButton.icon(
  icon: Icon(Icons.quiz),
  label: Text('A1 Abschlussprüfung - 60 Fragen'),
  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExamScreen(levelId: 'a1'))),
)
```
- Für Premium: Button nur für A1 frei, für A2+ hinter Paywall

### Schritt 6: pubspec.yaml - Keine Änderung nötig

### Schritt 7: Ausführen
```
flutter clean
flutter run -d chrome
```
- Klicke A1 -> Unten siehst du Button "Abschlussprüfung"
- Klicke -> 60 Fragen nacheinander

## FÜR DEINE CAFE BAZAAR MONETARISIERUNG:

- A1 Prüfung: Kostenlos (wie A1 Lektionen) - als Demo für Qualität
- A2, B1, B2... Prüfungen: Premium, nur mit Abo
- In `exam_screen.dart` kannst du am Ende "Teile dein Ergebnis" Button hinzufügen (viral für Cafe Bazaar)

---

Jetzt baue ich dir sofort die Dart-Datei für deine A1 Abschlussprüfung aus deinem Text (60 Fragen) nach diesem System!
