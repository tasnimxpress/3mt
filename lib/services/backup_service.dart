/// Backup & Restore service.
/// Full implementation in M6.
/// Stub present so imports compile cleanly across milestones.
class BackupService {
  BackupService._();

  static Future<void> exportToJson() async {
    // TODO: M6 — read all 6 tables, serialize to JSON, invoke FilePicker.saveFile()
    throw UnimplementedError('Backup export implemented in M6');
  }

  static Future<void> importFromJson() async {
    // TODO: M6 — FilePicker for .json, validate, confirmation dialog, restore
    throw UnimplementedError('Backup import implemented in M6');
  }
}
