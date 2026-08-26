// ============================================================
// ALL LESSONS DATABASE
// ============================================================
// Central registry for all lesson data.
//
// IMPORTANT:
// The lesson ID used here MUST exactly match:
//   1. mock_data.dart
//   2. the lesson data file
//   3. LessonScreen lookup
//
// Example:
//   "a2_l12" -> a2_l12_data
// ============================================================

import 'a1_l01_data.dart';
import 'a1_l02_data.dart';
import 'a1_l03_data.dart';
import 'a1_l04_data.dart';
import 'a1_l05_data.dart';
import 'a1_l06_data.dart';
import 'a1_l07_data.dart';
import 'a1_l08_data.dart';
import 'a1_l09_data.dart';
import 'a1_l10_data.dart';
import 'a1_l11_data.dart';
import 'a1_l12_data.dart';

import 'a2_l01_data.dart';
import 'a2_l02_data.dart';
import 'a2_l03_data.dart';
import 'a2_l04_data.dart';
import 'a2_l05_data.dart';
import 'a2_l06_data.dart';
import 'a2_l07_data.dart';
import 'a2_l08_data.dart';
import 'a2_l09_data.dart';
import 'a2_l10_data.dart';
import 'a2_l11_data.dart';
import 'a2_l12_data.dart';

import 'b1_l01_data.dart';

// ============================================================
// MASTER LESSON DATABASE
// ============================================================

final Map<String, Map<String, dynamic>> allLessonsDatabase = {
  // ==========================================================
  // A1
  // ==========================================================

  'a1_l01': a1_l01_data,
  'a1_l02': a1_l02_data,
  'a1_l03': a1_l03_data,
  'a1_l04': a1_l04_data,
  'a1_l05': a1_l05_data,
  'a1_l06': a1_l06_data,
  'a1_l07': a1_l07_data,
  'a1_l08': a1_l08_data,
  'a1_l09': a1_l09_data,
  'a1_l10': a1_l10_data,
  'a1_l11': a1_l11_data,
  'a1_l12': a1_l12_data,

  // ==========================================================
  // A2
  // ==========================================================

  'a2_l01': a2_l01_data,
  'a2_l02': a2_l02_data,
  'a2_l03': a2_l03_data,
  'a2_l04': a2_l04_data,
  'a2_l05': a2_l05_data,
  'a2_l06': a2_l06_data,
  'a2_l07': a2_l07_data,
  'a2_l08': a2_l08_data,
  'a2_l09': a2_l09_data,
  'a2_l10': a2_l10_data,
  'a2_l11': a2_l11_data,
  'a2_l12': a2_l12_data,

  // ==========================================================
  // B1
  // ==========================================================

  'b1_l01': b1_l01_data,
};
