// ============================================================
// MOCK DATA
// German Learning App
// ============================================================

// ============================================================
// LEVELS
// ============================================================

final List<Map<String, dynamic>> levels = [
  {
    "id": "A1",
    "title": "Level A1 - Beginner",
    "subtitle": "Free - Complete 12 Lessons",
    "isFree": true,
    "lessonCount": 12,
    "color": 0xFF4CAF50,
  },
  {
    "id": "A2",
    "title": "Level A2 - Elementary",
    "subtitle": "Premium - Testing Mode",
    "isFree": true,
    "lessonCount": 12,
    "color": 0xFF2196F3,
  },
  {
    "id": "B1",
    "title": "Level B1 - Intermediate",
    "subtitle": "Premium - Testing Mode",
    "isFree": true,
    "lessonCount": 15,
    "color": 0xFFFF9800,
  },
  {
    "id": "B2",
    "title": "Level B2 - Upper Intermediate",
    "subtitle": "Premium - Testing Mode",
    "isFree": true,
    "lessonCount": 15,
    "color": 0xFFE91E63,
  },
  {
    "id": "C1",
    "title": "Level C1 - Advanced",
    "subtitle": "Premium - Testing Mode",
    "isFree": true,
    "lessonCount": 10,
    "color": 0xFF9C27B0,
  },
  {
    "id": "C2",
    "title": "Level C2 - Mastery",
    "subtitle": "Premium - Testing Mode",
    "isFree": true,
    "lessonCount": 10,
    "color": 0xFF607D8B,
  },
];

// ============================================================
// A1 LESSONS
// ============================================================

final List<Map<String, dynamic>> mockA1Lessons = List.generate(12, (index) {
  final numStr = (index + 1).toString().padLeft(2, '0');

  String titleDe;
  String titleFa;
  String grammar;

  if (index == 0) {
    titleDe = "Der falsche Koffer";
    titleFa = "چمدان اشتباه";
    grammar = "sein, kommen aus, nehmen";
  } else if (index == 1) {
    titleDe = "Neue Freunde in Berlin";
    titleFa = "دوستان جدید در برلین";
    grammar = "ein, kein, mein, -in";
  } else if (index == 2) {
    titleDe = "Die falsche U-Bahn";
    titleFa = "متروی اشتباه";
    grammar = "sein, haben, Vokalwechsel, Imperativ";
  } else if (index == 3) {
    titleDe = "Ein überraschender Anruf";
    titleFa = "تماس غیرمنتظره";
    grammar = "Vokalwechsel, trennbare Verben, man, Akkusativ";
  } else if (index == 4) {
    titleDe = "Das Stadtfest";
    titleFa = "جشن شهری";
    grammar =
        "Vokalwechsel, trennbare Verben, können/müssen, in + Akkusativ, am";
  } else if (index == 5) {
    titleDe = "Die WG-Party - Wo ist mein Schlüssel?";
    titleFa = "مهمانی خانه اشتراکی - کلیدم کجاست؟";
    grammar = "ja/nein/doch, auf/in + Dativ, es gibt";
  } else if (index == 6) {
    titleDe = "Der Dachboden bei Annas Familie";
    titleFa = "اتاق زیر شیروانی در خانه خانواده آنا";
    grammar = "Perfekt mit haben, Präteritum sein, am Datum";
  } else if (index == 7) {
    titleDe = "Amir lernt Fahrradfahren";
    titleFa = "امیر دوچرخه‌سواری یاد می‌گیرد";
    grammar = "Akkusativ-Pronomen, über, mit, aber/und";
  } else if (index == 8) {
    titleDe = "Amirs Kochabend";
    titleFa = "شب آشپزی امیر";
    grammar = "mögen, wollen, Nomen + Nomen, oder, denn";
  } else if (index == 9) {
    titleDe = "Der Ausflug nach Potsdam";
    titleFa = "گردش به پوتسدام";
    grammar = "Perfekt unregelmäßig, würde, wer, im, nach";
  } else if (index == 10) {
    titleDe = "Willkommen bei uns - WG Einzug";
    titleFa = "به جمع ما خوش آمدی - اسباب‌کشی به خانه اشتراکی";
    grammar = "dürfen, Dativ-Verben, ihr Imperativ, unser";
  } else {
    titleDe = "Sechs Monate in Berlin - Präsentation";
    titleFa = "شش ماه در برلین - ارائه";
    grammar = "Präteritum haben, sollen, Genitiv, vor/nach";
  }

  return {
    "id": "a1_l$numStr",
    "number": index + 1,
    "title_de": titleDe,
    "title_fa": titleFa,
    "grammar": grammar,
    "isLocked": false,
  };
});

// ============================================================
// A2 LESSONS
// COMPLETE: L01 - L12
// ============================================================

final List<Map<String, dynamic>> mockA2Lessons = [
  // ----------------------------------------------------------
  // A2 L01
  // ----------------------------------------------------------
  {
    "id": "a2_l01",
    "number": 1,
    "title_de": "Ein neues Kapitel",
    "title_fa": "فصلی جدید",
    "grammar": "Perfekt trennbar, Dativ, weil, seit",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L02
  // ----------------------------------------------------------
  {
    "id": "a2_l02",
    "number": 2,
    "title_de": "Der Flohmarkt und das geheimnisvolle Buch",
    "title_fa": "بازار دست‌دوم و کتاب اسرارآمیز",
    "grammar": "dieser, welcher, Nationalitäten, Komparativ",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L03
  // ----------------------------------------------------------
  {
    "id": "a2_l03",
    "number": 3,
    "title_de": "Der Name im alten Brief",
    "title_fa": "نام در نامه قدیمی",
    "grammar": "Präteritum, Konjunktiv II mit sollen, reziproke Verben, un-",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L04
  // ----------------------------------------------------------
  {
    "id": "a2_l04",
    "number": 4,
    "title_de": "Das Escape-Zimmer",
    "title_fa": "اتاق فرار",
    "grammar": "Wechselpräpositionen, stellen/stehen, euer",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L05
  // ----------------------------------------------------------
  {
    "id": "a2_l05",
    "number": 5,
    "title_de": "Ein neuer Alltag",
    "title_fa": "یک زندگی روزمره جدید",
    "grammar":
        "Konjunktiv II, temporale Präpositionen, Komparativ und Superlativ",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L06
  // ----------------------------------------------------------
  {
    "id": "a2_l06",
    "number": 6,
    "title_de": "Ein besonderer Tag",
    "title_fa": "یک روز خاص",
    "grammar": "Adjektivdeklination, Vergleiche, temporale Präpositionen",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L07
  // ----------------------------------------------------------
  {
    "id": "a2_l07",
    "number": 7,
    "title_de": "Eine wichtige Entscheidung",
    "title_fa": "یک تصمیم مهم",
    "grammar": "Adjektivdeklination, Vergleiche, Konjunktiv II",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L08
  // ----------------------------------------------------------
  {
    "id": "a2_l08",
    "number": 8,
    "title_de": "Ein neuer Weg",
    "title_fa": "یک مسیر جدید",
    "grammar":
        "Konjunktiv II mit sein, temporale Präpositionen, Komparativ und Superlativ, Adjektivdeklination nach indefinitem Artikel",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L09
  // ----------------------------------------------------------
  {
    "id": "a2_l09",
    "number": 9,
    "title_de": "Ein neuer Plan",
    "title_fa": "یک برنامه جدید",
    "grammar":
        "Konnektor dann, Adjektivdeklination nach indefinitem Artikel im Akkusativ und Dativ, Verben mit Dativ- und Akkusativergänzung",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L10
  // ----------------------------------------------------------
  {
    "id": "a2_l10",
    "number": 10,
    "title_de": "Ein wichtiger Schritt",
    "title_fa": "یک قدم مهم",
    "grammar":
        "lassen, Verben mit Dativ- und Akkusativergänzung, Genitiv, Adjektivdeklination nach definitem Artikel, aus, über + Akkusativ",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L11
  // ----------------------------------------------------------
  {
    "id": "a2_l11",
    "number": 11,
    "title_de": "Ein neuer Weg",
    "title_fa": "یک مسیر جدید",
    "grammar":
        "Passiv Präsens, indirekte Fragen mit Fragewort und ob, wem, Possessivartikel ihr",
    "isLocked": false,
  },

  // ----------------------------------------------------------
  // A2 L12
  // ----------------------------------------------------------
  {
    "id": "a2_l12",
    "number": 12,
    "title_de": "Ein letzter Schritt",
    "title_fa": "یک قدم آخر",
    "grammar":
        "Verben mit präpositionaler Ergänzung, Präpositionaladverbien, Wechselpräpositionen, aus/von/bis zu, für",
    "isLocked": false,
  },
];

// ============================================================
// B1 LESSONS
// COMPLETE CURRENT TESTING LESSONS
// ============================================================

final List<Map<String, dynamic>> mockB1Lessons = [
  {
    "id": "b1_l01",
    "number": 1,
    "title_de": "Ein neuer Anfang",
    "title_fa": "شروعی جدید",
    "grammar":
        "Infinitiv mit zu, trotzdem, Adjektivdeklination mit Superlativ, Wortbildung Adjektiv → Nomen",
    "isLocked": false,
  },
];

// ============================================================
// FUTURE LEVELS
// These are intentionally empty for now.
// The lessonCount in levels determines how many lessons
// the level screen displays.
// ============================================================

final List<Map<String, dynamic>> mockB2Lessons = [];

final List<Map<String, dynamic>> mockC1Lessons = [];

final List<Map<String, dynamic>> mockC2Lessons = [];
