import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'db/database_helper.dart';
import 'core/utils/recurring_engine.dart';
import 'providers/settings_provider.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait orientation.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style — dark status bar for dark theme.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF13131A),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Initialize database (creates tables + seeds on first launch).
  final db = await DatabaseHelper.instance.database;

  // Run recurring engine before UI renders (cold launch only).
  await RecurringEngine.processOverdue(db);

  // Run app inside ProviderScope.
  runApp(
    ProviderScope(
      overrides: [],
      child: const _AppStarter(),
    ),
  );
}

/// Loads settings before rendering App to avoid flash of wrong state.
class _AppStarter extends ConsumerStatefulWidget {
  const _AppStarter();

  @override
  ConsumerState<_AppStarter> createState() => _AppStarterState();
}

class _AppStarterState extends ConsumerState<_AppStarter> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await ref.read(settingsProvider.notifier).load();
    if (mounted) setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      // Minimal splash while settings load (< 50ms typically).
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFF0A0A0F),
          body: SizedBox.shrink(),
        ),
      );
    }
    return const App();
  }
}
