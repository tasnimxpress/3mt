import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class CategoryManagementScreen extends ConsumerWidget {
  final String type; // 'earning' | 'expense' | 'saving'

  const CategoryManagementScreen({super.key, required this.type});

  String get _title {
    switch (type) {
      case 'earning':
        return 'Earning Categories';
      case 'expense':
        return 'Expense Categories';
      case 'saving':
        return 'Saving Categories';
      default:
        return 'Categories';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(_title, style: AppTextStyles.sectionTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '$_title — Coming soon',
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
