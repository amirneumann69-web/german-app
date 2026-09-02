import 'package:flutter/material.dart';
import '../design/design_system.dart';

class FortschrittScreen extends StatelessWidget {
  const FortschrittScreen({super.key});

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
                'Fortschritt',
                style: AppTypography.germanTitle,
              ),
              const SizedBox(height: 8),
              Text(
                'پیشرفت یادگیری شما',
                textDirection: TextDirection.rtl,
                style: AppTypography.persianBody,
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.show_chart,
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
                      'در این بخش آمار یادگیری، روزهای متوالی تمرین و نوار پیشرفت هر سطح نمایش داده خواهد شد.',
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
