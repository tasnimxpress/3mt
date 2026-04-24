import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/queries/settings_queries.dart';

class SettingsNotifier extends StateNotifier<Map<String, String>> {
  SettingsNotifier() : super({});

  Future<void> load() async {
    state = await SettingsQueries.getAll();
  }

  Future<void> set(String key, String value) async {
    await SettingsQueries.set(key, value);
    state = {...state, key: value};
  }

  String get(String key, {String defaultValue = ''}) {
    return state[key] ?? defaultValue;
  }

  String get currency => get('currency', defaultValue: 'BDT');
  String get currencySymbol {
    const symbols = {
      'BDT': '৳',
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'AED': 'د.إ',
      'SGD': 'S\$',
    };
    return symbols[currency] ?? '৳';
  }

  String get theme => get('theme', defaultValue: 'dark');
  int get monthStart => int.tryParse(get('month_start', defaultValue: '1')) ?? 1;
  bool get haptic => get('haptic', defaultValue: 'true') == 'true';
  int get targetSavePct =>
      int.tryParse(get('target_save_pct', defaultValue: '30')) ?? 30;
  int get targetSpendPct =>
      int.tryParse(get('target_spend_pct', defaultValue: '50')) ?? 50;
  String get lastBackup => get('last_backup', defaultValue: '');
  String get nudgeDismissedDate =>
      get('nudge_dismissed_date', defaultValue: '');
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Map<String, String>>(
  (ref) => SettingsNotifier(),
);
