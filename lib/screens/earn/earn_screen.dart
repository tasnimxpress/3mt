import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../providers/selected_month_provider.dart';
import '../../core/utils/date_helpers.dart';
import '../../widgets/shared/screen_header.dart';

class EarnScreen extends ConsumerWidget {
  const EarnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(selectedMonthProvider);
    final monthLabel = DateHelpers.toMonthYear(month);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabScreenHeader(
              title: 'Earnings',
              subtitle: '$monthLabel • BDT 0 total',
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Earn — Coming soon',
                  style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
