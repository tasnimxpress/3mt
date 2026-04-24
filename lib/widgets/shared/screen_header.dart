import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../core/utils/date_helpers.dart';
import '../../providers/selected_month_provider.dart';

/// Shared header for Earn, Spend, Save tabs.
/// Shows title, subtitle (with total), month nav arrows, and gear icon.
class TabScreenHeader extends ConsumerWidget {
  final String title;
  final String? subtitle; // e.g. "April 2026 • BDT 1,50,000 total"

  const TabScreenHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = ref.watch(selectedMonthProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: AppTextStyles.subtitleSecondary),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Month navigation
          Row(
            children: [
              _MonthArrowButton(
                icon: Icons.chevron_left,
                onTap: () => ref.read(selectedMonthProvider.notifier).state =
                    DateHelpers.previousMonth(selectedMonth),
              ),
              const SizedBox(width: 4),
              _MonthArrowButton(
                icon: Icons.chevron_right,
                onTap: () => ref.read(selectedMonthProvider.notifier).state =
                    DateHelpers.nextMonth(selectedMonth),
              ),
            ],
          ),
          const SizedBox(width: 8),
          // Gear icon
          GestureDetector(
            onTap: () => context.push('/settings'),
            child: const Icon(Icons.settings_outlined,
                color: AppColors.textSecondary, size: 22),
          ),
        ],
      ),
    );
  }
}

/// Dashboard-specific header — different layout (month on left, gear right).
class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final monthLabel = DateHelpers.toMonthYear(selectedMonth);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => ref.read(selectedMonthProvider.notifier).state =
                    DateHelpers.previousMonth(selectedMonth),
                child: const Icon(Icons.chevron_left,
                    color: AppColors.textPrimary, size: 22),
              ),
              const SizedBox(width: 6),
              Text(
                monthLabel,
                style: AppTextStyles.sectionTitle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => ref.read(selectedMonthProvider.notifier).state =
                    DateHelpers.nextMonth(selectedMonth),
                child: const Icon(Icons.chevron_right,
                    color: AppColors.textPrimary, size: 22),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push('/settings'),
                child: const Icon(Icons.settings_outlined,
                    color: AppColors.textSecondary, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Hello there...', style: AppTextStyles.subtitleSecondary),
        ],
      ),
    );
  }
}

class _MonthArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MonthArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 18),
      ),
    );
  }
}
