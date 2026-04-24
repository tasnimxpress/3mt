import 'package:flutter/material.dart';
import 'core/constants/colors.dart';
import 'core/constants/text_styles.dart';
import 'core/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '3MT',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: _buildTheme(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        primary: AppColors.earn,
        secondary: AppColors.save,
        error: AppColors.spend,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
      ),
      // Override all Material 3 component defaults to match design system.
      // Do NOT use Material 3 generated color scheme.
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.sectionTitle,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.earn,
        unselectedItemColor: AppColors.textSecondary,
      ),
      cardTheme: CardThemeData (
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      dividerColor: AppColors.border,
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle:
            AppTextStyles.body.copyWith(color: AppColors.textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.black;
          return AppColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.earn;
          return AppColors.border;
        }),
      ),
      fontFamily: 'DMSans',
      textTheme: TextTheme(
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.subtitle,
        labelSmall: AppTextStyles.tinyLabel,
        titleMedium: AppTextStyles.sectionTitle,
        titleSmall: AppTextStyles.cardTitle,
      ),
    );
  }
}
