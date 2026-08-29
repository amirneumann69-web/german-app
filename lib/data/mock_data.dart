// ============================================================
// MOCK DATA
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
    "subtitle": "Premium - Complete 12 Lessons",
    "isFree": true,
    "lessonCount": 12,
    "color": 0xFF2196F3,
  },
  {
    "id": "B1",
    "title": "Level B1 - Intermediate",
    "subtitle": "Premium - Complete 12 Lessons",
    "isFree": true,
    "lessonCount": 12,
    "color": 0xFFFF9800,
  },
  {
    "id": "B2",
    "title": "Level B2 - Upper Intermediate",
    "subtitle": "Premium - Testing Mode (7 Lessons)",
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
// ============================================================

final List<Map<String, dynamic>> mockA2Lessons = List.generate(12, (index) {
  final numStr = (index + 1).toString().padLeft(2, '0');

  String titleDe;
  String titleFa;
  String grammar;

  if (index == 0) {
    titleDe = "Ein neues Kapitel";
    titleFa = "فصلی جدید";
    grammar = "Perfekt trennbar, Dativ, weil, seit";
  } else if (index == 1) {
    titleDe = "Der Flohmarkt und das geheimnisvolle Buch";
    titleFa = "بازار دست‌دوم و کتاب اسرارآمیز";
    grammar = "dieser, welcher, Nationalitäten, Komparativ";
  } else if (index == 2) {
    titleDe = "Der Name im alten Brief";
    titleFa = "نام در نامه قدیمی";
    grammar = "Präteritum, Konjunktiv II sollen, reziproke Verben, un-";
  } else if (index == 3) {
    titleDe = "Das Escape-Zimmer";
    titleFa = "اتاق فرار";
    grammar = "Wechselpräpositionen, stellen/stehen, euer";
  } else if (index == 4) {
    titleDe = "Ein unerwarteter Besuch";
    titleFa = "یک دیدار غیرمنتظره";
    grammar = "A2 Grammatik";
  } else if (index == 5) {
    titleDe = "Ein wichtiger Entschluss";
    titleFa = "یک تصمیم مهم";
    grammar = "A2 Grammatik";
  } else if (index == 6) {
    titleDe = "Ein neuer Alltag";
    titleFa = "یک زندگی روزمره جدید";
    grammar = "A2 Grammatik";
  } else if (index == 7) {
    titleDe = "Ein besonderer Tag";
    titleFa = "یک روز خاص";
    grammar =
        "Konjunktiv II, temporale Präpositionen, Komparativ und Superlativ";
  } else if (index == 8) {
    titleDe = "Ein guter Plan";
    titleFa = "یک برنامه خوب";
    grammar =
        "Konnektor dann, Adjektivdeklination, Dativ- und Akkusativobjekte";
  } else if (index == 9) {
    titleDe = "Die nächste Entscheidung";
    titleFa = "تصمیم بعدی";
    grammar =
        "lassen, Dativ- und Akkusativergänzung, Genitiv, Adjektivdeklination";
  } else if (index == 10) {
    titleDe = "Ein neuer Weg";
    titleFa = "یک مسیر جدید";
    grammar = "Passiv Präsens, indirekte Fragen, wem?, Possessivartikel ihr";
  } else {
    titleDe = "Ein letzter Schritt";
    titleFa = "یک قدم آخر";
    grammar =
        "Präpositionale Ergänzungen, Präpositionaladverbien, Wechselpräpositionen, aus/von/bis zu, für";
  }

  return {
    "id": "a2_l$numStr",
    "number": index + 1,
    "title_de": titleDe,
    "title_fa": titleFa,
    "grammar": grammar,
    "isLocked": false,
  };
});

// ============================================================
// B1 LESSONS
// ============================================================

final List<Map<String, dynamic>> mockB1Lessons = List.generate(12, (index) {
  final numStr = (index + 1).toString().padLeft(2, '0');

  String titleDe;
  String titleFa;
  String grammar;

  if (index == 0) {
    titleDe = "Ein neuer Anfang";
    titleFa = "شروعی جدید";
    grammar =
        "Infinitiv mit zu, trotzdem, Adjektivdeklination mit Superlativ, Wortbildung Adjektiv → Nomen";
  } else if (index == 1) {
    titleDe = "Neue Pläne";
    titleFa = "برنامه‌های جدید";
    grammar =
        "Futur I, obwohl, je ... desto, deshalb/darum/deswegen/daher, während, Genitiv";
  } else if (index == 2) {
    titleDe = "Ein Blick zurück";
    titleFa = "نگاهی به گذشته";
    grammar =
        "Plusquamperfekt, Genitivdeklination, wegen, trotz, während, bevor, zu + Infinitiv, Verb → Nomen";
  } else if (index == 3) {
    titleDe = "Ein gutes Ziel";
    titleFa = "یک هدف خوب";
    grammar = "um ... zu, damit, über, Passiv: Agens, Nomen/Verb → Adjektiv";
  } else if (index == 4) {
    titleDe = "Ein Ort für alle";
    titleFa = "مکانی برای همه";
    grammar =
        "Nullartikel-Adjektivdeklination, nicht nur ... sondern auch, sowohl ... als auch, Nomen + -chen";
  } else if (index == 5) {
    titleDe = "Eine unerwartete Veränderung";
    titleFa = "یک تغییر غیرمنتظره";
    grammar =
        "Passiv Präteritum, sodass, nämlich, innerhalb/außerhalb, Verben mit Präpositionen";
  } else if (index == 6) {
    titleDe = "Eine schwierige Entscheidung";
    titleFa = "یک تصمیم دشوار";
    grammar = "Irrealer Bedingungssatz mit wenn, als, indem, weder ... noch";
  } else if (index == 7) {
    titleDe = "Ein unerwartetes Angebot";
    titleFa = "یک پیشنهاد غیرمنتظره";
    grammar =
        "Passiv Perfekt, Verben mit Präpositionen, sondern, seit(dem), als ob, zwar ... aber, gegen, um ... herum";
  } else if (index == 8) {
    titleDe = "Durch die Stadt";
    titleFa = "در میان شهر";
    grammar =
        "brauchen nicht/kein + zu + Infinitiv, durch, zwischen, Relativsätze, Relativpronomen, Partizip I";
  } else if (index == 9) {
    titleDe = "Eine neue Verantwortung";
    titleFa = "یک مسئولیت جدید";
    grammar =
        "Passiv mit Modalverb, ohne dass, ohne zu + Infinitiv, Relativsätze mit Präposition";
  } else if (index == 10) {
    titleDe = "Eine wichtige Entscheidung";
    titleFa = "یک تصمیم مهم";
    grammar =
        "n-Deklination, entweder ... oder, nachdem, anstatt dass, anstatt ... zu + Infinitiv";
  } else {
    titleDe = "Der nächste Schritt";
    titleFa = "قدم بعدی";
    grammar =
        "Zeitangaben mit jeder, derselbe, da, falls, haben/sein + zu + Infinitiv, Relativsätze mit wo/was";
  }

  return {
    "id": "b1_l$numStr",
    "number": index + 1,
    "title_de": titleDe,
    "title_fa": titleFa,
    "grammar": grammar,
    "isLocked": false,
  };
});

// ============================================================
// B2 LESSONS
// ============================================================

// ============================================================
// B2 LESSONS
// ============================================================

// ============================================================
// B2 LESSONS
// ============================================================

// ============================================================
// B2 LESSONS
// ============================================================

final List<Map<String, dynamic>> mockB2Lessons = List.generate(12, (index) {
  final numStr = (index + 1).toString().padLeft(2, '0');

  String titleDe;
  String titleFa;
  String grammar;

  if (index == 0) {
    titleDe = "Lea und das Gesundheitssystem";
    titleFa = "لئا و نظام سلامت";
    grammar =
        "Zweiteilige Konnektoren, Mittelfeld im Hauptsatz, Nachsilben bei Nomen";
  } else if (index == 1) {
    titleDe = "Wenn Technik entscheidet";
    titleFa = "وقتی فناوری تصمیم می‌گیرد";
    grammar =
        "Zustandspassiv, von/durch im Passiv, Vorsilben bei Nomen, kausale Zusammenhänge, Partizip I und II als Adjektive";
  } else if (index == 2) {
    titleDe = "Wem kann man glauben?";
    titleFa = "به چه کسی می‌توان اعتماد کرد؟";
    grammar =
        "Verweiswörter im Text, Nachsilben bei Adjektiven, uneingeleitete wenn-Sätze, dass-Sätze und ihre Entsprechungen";
  } else if (index == 3) {
    titleDe = "Zeit ist nicht immer Geld";
    titleFa = "زمان همیشه پول نیست";
    grammar =
        "Temporales Ausdrücken, temporale Zusammenhänge, Nachsilbe -weise bei Adverbien";
  } else if (index == 4) {
    titleDe = "Was wird bis morgen passiert sein?";
    titleFa = "تا فردا چه اتفاقی افتاده خواهد بود؟";
    grammar =
        "lassen, Futur II, Vermutungen, Verbverbindungen, Nominalisierung";
  } else if (index == 5) {
    titleDe = "Was wäre, wenn ...?";
    titleFa = "اگر ... چه می‌شد؟";
    grammar =
        "Konjunktiv II: irreale Bedingungen, Wünsche und Vergleiche, Adjektive mit Präpositionen";
  } else if (index == 6) {
    titleDe = "Worte, die verbinden";
    titleFa = "واژه‌هایی که ارتباط ایجاد می‌کنند";
    grammar =
        "Nomen mit Präposition, indirekte Rede, generalisierende Relativsätze, Vergleichssätze";
  } else if (index == 7) {
    titleDe = "Was soll das bedeuten?";
    titleFa = "این قرار است چه معنایی داشته باشد؟";
    grammar =
        "Subjektive Bedeutung von sollen, Nominalisierung von Verben, konditionale und konzessive Zusammenhänge";
  } else if (index == 8) {
    titleDe = "Wenn Worte Folgen haben";
    titleFa = "وقتی کلمات پیامد دارند";
    grammar =
        "Konsekutive Zusammenhänge, feste Nomen-Verb-Verbindungen, Negation durch Vor- und Nachsilben bei Adjektiven";
  } else if (index == 9) {
    titleDe = "Wenn man nicht „wird“ sagen muss";
    titleFa = "وقتی لازم نیست از «wird» استفاده کنیم";
    grammar = "Alternativen zum Passiv, subjektlose Passivsätze";
  } else if (index == 10) {
    titleDe = "Nicht jeder denkt gleich";
    titleFa = "همه یکسان فکر نمی‌کنند";
    grammar = "Indefinitpronomen, modale Zusammenhänge";
  } else {
    titleDe = "Die Dinge, die bleiben";
    titleFa = "چیزهایی که باقی می‌مانند";
    grammar =
        "Erweitertes Partizip, Adversativsätze, Partizipien als Nomen, Fugenelement -s-";
  }

  return {
    "id": "b2_l$numStr",
    "number": index + 1,
    "title_de": titleDe,
    "title_fa": titleFa,
    "grammar": grammar,
    "isLocked": false,
  };
});
