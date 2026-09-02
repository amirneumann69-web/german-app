import 'package:flutter/material.dart';
import '../design/design_system.dart';

class UebungenScreen extends StatelessWidget {
  const UebungenScreen({super.key});

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
              const Text(
                'Übungen',
                style: AppTypography.germanTitle,
              ),
              const SizedBox(height: 8),
              Text(
                'تمرین‌ها و آزمون‌های هر سطح',
                textDirection: TextDirection.rtl,
                style: AppTypography.persianBody,
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.quiz_outlined,
                      size: 72,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'به‌زودی!',
                      textDirection: TextDirection.rtl,
                      style: AppTypography.cardTitle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'در این بخش آزمون پایان هر سطح و تمرین‌های اضافی قرار خواهد گرفت.',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: AppTypography.persianBody,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
