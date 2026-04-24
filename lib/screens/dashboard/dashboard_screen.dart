import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../widgets/shared/screen_header.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashboardHeader(),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Font test — Instrument Serif
                    Text(
                      'BDT 1,19,500',
                      style: AppTextStyles.balanceDisplay,
                    ),
                    const SizedBox(height: 8),
                    // Font test — DM Sans
                    Text(
                      'Dashboard — Coming Soon',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 8),
                    // Font test — JetBrains Mono
                    Text(
                      '+1,50,000',
                      style: AppTextStyles.amount.copyWith(
                        color: AppColors.earn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
