import 'package:flutter/material.dart';
import '../design/design_system.dart';

class HomeLernenScreen extends StatelessWidget {
  const HomeLernenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hallo, Amir', style: AppTypography.germanTitle.copyWith(fontSize: 22)),
                          const SizedBox(height: 4),
                          Text('Bereit für deine nächste Lektion?', textDirection: TextDirection.rtl, style: AppTypography.persianBody.copyWith(fontSize: 14)),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined, color: AppColors.textSecondary)),
                    const SizedBox(width: 8),
                    CircleAvatar(radius: 20, backgroundColor: AppColors.primary, child: const Text('A', style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ),
            
            // Current Level + Progress
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: PremiumCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const LevelBadge(level: 'A1'),
                          const SizedBox(width: 8),
                          Text('Deutsch lernen', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text('A1 Fortschritt', style: AppTypography.cardTitle),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          const ProgressRing(progress: 0.68),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('8 von 12 Lektionen', style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                                const SizedBox(height: 4),
                                Text('68% abgeschlossen • 5 Tage Streak', style: AppTypography.caption),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(value: 0.68, backgroundColor: AppColors.progressBackground, color: AppColors.primary, minHeight: 6),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
            
            // Weiterlernen
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Weiterlernen', style: AppTypography.sectionTitle),
                    const SizedBox(height: AppSpacing.md),
                    PremiumCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSecondary,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                              image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1526772661823-3f88f33771cd?w=600'), fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('LEKTION 10', style: AppTypography.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                                    const Spacer(),
                                    Text('10-15 Min.', style: AppTypography.caption),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text('Der Ausflug nach Potsdam', style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                                const SizedBox(height: 4),
                                Text('Amir entdeckt Potsdam und hilft einem Fremden.', style: AppTypography.persianBody.copyWith(fontSize: 13)),
                                const SizedBox(height: AppSpacing.md),
                                ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: 0.3, backgroundColor: AppColors.progressBackground, minHeight: 4)),
                                const SizedBox(height: AppSpacing.md),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    child: const Text('Fortsetzen'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
            
            // Deine Lernbereiche
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Deine Lernbereiche', style: AppTypography.sectionTitle),
                    const SizedBox(height: AppSpacing.md),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.1,
                      children: [
                        _areaCard(Icons.menu_book_outlined, 'Lektionen', '12 Lektionen', 0.68),
                        _areaCard(Icons.auto_stories_outlined, 'Lesegeschichten', '15 Geschichten', 0.4),
                        _areaCard(Icons.translate_outlined, 'Wortschatz', '240 Wörter', 0.55),
                        _areaCard(Icons.rule_outlined, 'Grammatik', '32 Themen', 0.6),
                        _areaCard(Icons.quiz_outlined, 'Übungen', '86 Aufgaben', 0.45),
                        _areaCard(Icons.emoji_events_outlined, 'Test', 'A1 Abschluss', 0.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _areaCard(IconData icon, String title, String subtitle, double progress) {
    return PremiumCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const Spacer(),
          Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
          const SizedBox(height: 2),
          Text(subtitle, style: AppTypography.caption.copyWith(fontSize: 11)),
          const SizedBox(height: 8),
          ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: progress, backgroundColor: AppColors.progressBackground, minHeight: 4, color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.borderLight))),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.school, 'Lernen', true),
              _navItem(Icons.auto_stories, 'Geschichten', false),
              _navItem(Icons.quiz_outlined, 'Übungen', false),
              _navItem(Icons.show_chart, 'Fortschritt', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? AppColors.primary : AppColors.textTertiary, size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, fontWeight: active ? FontWeight.w600 : FontWeight.w400, color: active ? AppColors.primary : AppColors.textTertiary)),
      ],
    );
  }
}
