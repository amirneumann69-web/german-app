import 'package:flutter/material.dart';

// ============================================
// PREMIUM GERMAN LEARNING APP - DESIGN SYSTEM
// Adult-oriented, calm, educational, not childish
// ============================================

class AppColors {
  // Light Mode - Premium, calm, German-inspired
  static const background = Color(0xFFFAF8F5); // Warm paper
  static const surface = Colors.white;
  static const surfaceSecondary = Color(0xFFF5F2ED);

  static const primary =
      Color(0xFF1A2E4E); // Deep Prussian Blue - German academic
  static const primaryLight = Color(0xFF2C4A73);
  static const accent = Color(0xFFC8A96E); // Warm gold - premium accent
  static const accentLight = Color(0xFFF0E6D3);

  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B6B6B);
  static const textTertiary = Color(0xFF9E9E9E);

  static const success = Color(0xFF2E7D32);
  static const successLight = Color(0xFFE8F5E9);
  static const error = Color(0xFFC62828);
  static const errorLight = Color(0xFFFFEBEE);
  static const warning = Color(0xFFF57F17);

  static const border = Color(0xFFE8E0D5);
  static const borderLight = Color(0xFFF0EBE3);

  static const progressBackground = Color(0xFFEFEBE6);
}

class AppTypography {
  // German text - LTR, highly readable
  static const germanTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const germanBody = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 1.7,
    color: AppColors.textPrimary,
  );

  static const germanBodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.8,
    color: AppColors.textPrimary,
  );

  static const sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const cardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // Persian text - RTL
  static const persianBody = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.9,
    color: AppColors.textSecondary,
  );

  static const persianSmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.8,
    color: AppColors.textSecondary,
  );

  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textTertiary,
    letterSpacing: 0.3,
  );

  static const buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );
}

class AppSpacing {
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 20.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

class AppRadius {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;
}

class AppShadows {
  static const card = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 12,
    offset: Offset(0, 4),
  );
  static const cardHover = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 20,
    offset: Offset(0, 8),
  );
}

// Reusable Components
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
      child: Text(level,
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
    );
  }
}

class ProgressRing extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  const ProgressRing({super.key, required this.progress, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 4,
            color: AppColors.progressBackground,
          ),
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            color: AppColors.primary,
            strokeCap: StrokeCap.round,
          ),
          Center(
              child: Text('${(progress * 100).toInt()}%',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700))),
        ],
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  const PremiumCard({super.key, required this.child, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: const [AppShadows.card],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
            child: child,
          ),
        ),
      ),
    );
  }
}
