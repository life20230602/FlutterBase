import 'package:shared_preferences/shared_preferences.dart';

class CacheUtils {
  static SharedPreferences? prefs;

  static bool isInit() => prefs != null;

  static Future<SharedPreferences> init() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!;
  }

  static void putString(String key, String? value) {
    prefs!.setString(key, value ?? "");
  }

  static String? getString(String key) {
    return prefs!.getString(key);
  }

  static void putInt(String key, int? value) {
    prefs!.setInt(key, value ?? -1);
  }

  static int? getInt(String key) {
    return prefs!.getInt(key);
  }

  static void remove(String key) {
    prefs!.remove(key);
  }
}
