import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_keys.dart';

class SessionService {
  SessionService(this._prefs);

  final SharedPreferences _prefs;

  bool get hasOnboarding => _prefs.getBool(StorageKeys.hasOnboarding) ?? false;

  Future<void> saveOnboarding(bool value) async {
    await _prefs.setBool(StorageKeys.hasOnboarding, value);
  }

  String get themeMode => _prefs.getString(StorageKeys.themeMode) ?? 'light';

  Future<void> saveThemeMode(String value) async {
    await _prefs.setString(StorageKeys.themeMode, value);
  }

  String get token => _prefs.getString(StorageKeys.token) ?? '';

  Future<void> saveToken(String token) async {
    await _prefs.setString(StorageKeys.token, token);
  }

  Future<void> removeToken() async {
    await _prefs.remove(StorageKeys.token);
    await _prefs.remove(StorageKeys.userRoleKey);
  }

  bool get hasSession => token.isNotEmpty;

  Future<void> clearSession() async {
    await _prefs.clear();
  }

  String get userRole => _prefs.getString(StorageKeys.userRoleKey) ?? 'user';

  Future<void> saveUserRole(String value) async {
    await _prefs.setString(StorageKeys.userRoleKey, value);
  }
}
