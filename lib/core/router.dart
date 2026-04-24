import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/dashboard/dashboard_screen.dart';
import '../screens/earn/earn_screen.dart';
import '../screens/spend/spend_screen.dart';
import '../screens/save/save_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/category_management_screen.dart';
import '../widgets/shared/bottom_nav_bar.dart';

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/earn',
              builder: (context, state) => const EarnScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/spend',
              builder: (context, state) => const SpendScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/save',
              builder: (context, state) => const SaveScreen(),
            ),
          ],
        ),
      ],
    ),

    // Settings routes — outside the shell (no bottom nav).
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
      routes: [
        GoRoute(
          path: 'categories/earning',
          builder: (context, state) =>
              const CategoryManagementScreen(type: 'earning'),
        ),
        GoRoute(
          path: 'categories/expense',
          builder: (context, state) =>
              const CategoryManagementScreen(type: 'expense'),
        ),
        GoRoute(
          path: 'categories/saving',
          builder: (context, state) =>
              const CategoryManagementScreen(type: 'saving'),
        ),
      ],
    ),
  ],
);

/// Shell widget that wraps the 4 tab branches with the bottom nav bar.
class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
