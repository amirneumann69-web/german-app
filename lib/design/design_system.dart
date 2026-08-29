import 'package:flutter/material.dart';

// ============================================================
// AppColors - All colors used in the app
// ============================================================

class AppColors {
  static const Color primary = Color(0xFF1A2E4E);
  static const Color primaryLight = Color(0xFF2A4A7A);
  static const Color accent = Color(0xFFC8A96E);
  static const Color accentLight = Color(0xFFE8D5A8);
  static const Color background = Color(0xFFFAF8F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF5F3F0);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFFB0B0B0);
  static const Color borderLight = Color(0xFFEEEEEE);
  static const Color border = Color(0xFFE0E0E0);
  static const Color progressBackground = Color(0xFFE8E8E8);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE74C3C);
}

// ============================================================
// AppTypography - All text styles
// ============================================================

class AppTypography {
  // German
  static const TextStyle germanTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle germanBody = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 1.7,
    color: AppColors.textPrimary,
  );

  // Persian
  static const TextStyle persianBody = TextStyle(
    fontFamily: 'Vazir',
    fontSize: 15,
    height: 1.8,
    color: AppColors.textSecondary,
  );

  static const TextStyle persianSmall = TextStyle(
    fontFamily: 'Vazir',
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  // Shared
  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}

// ============================================================
// AppSpacing - All spacing values
// ============================================================

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 32.0;
}

// ============================================================
// AppRadius - All border radius values
// ============================================================

class AppRadius {
  static const double sm = 6.0;
  static const double md = 10.0;
  static const double lg = 16.0;
}

// ============================================================
// Reusable Widgets
// ============================================================

class LevelBadge extends StatelessWidget {
  final String level;
  const LevelBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        level,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ProgressRing extends StatelessWidget {
  final double progress;
  const ProgressRing({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            strokeWidth: 5,
            backgroundColor: AppColors.progressBackground,
            color: AppColors.primary,
          ),
          Text(
            '${(progress * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const PremiumCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ============================================================
// DesignSystem - Legacy compatibility
// ============================================================

class DesignSystem {
  static const Color primary = AppColors.primary;
  static const Color background = AppColors.background;
  static const Color accent = AppColors.accent;
  static const Color textPrimary = AppColors.textPrimary;
  static const Color textSecondary = AppColors.textSecondary;

  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  static const TextStyle germanStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    height: 1.7,
    color: textPrimary,
  );

  static const TextStyle persianStyle = TextStyle(
    fontFamily: 'Vazir',
    fontSize: 15,
    height: 1.9,
    color: textSecondary,
  );
}
