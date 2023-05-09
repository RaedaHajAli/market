import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPref;
  static init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) {
    if (value is bool) {
      return sharedPref.setBool(key, value);
    } else if (value is String) {
      return sharedPref.setString(key, value);
    } else if (value is int) {
      return sharedPref.setInt(key, value);
    } else if (value is double) {
      return sharedPref.setDouble(key, value);
    } else {
      return sharedPref.setStringList(key, value);
    }
  }

  static String? getString({required String key}) {
    return sharedPref.getString(key);
  }

  static bool? getBool({required String key}) {
    return sharedPref.getBool(key);
  }

 static Future<bool> remove({required String key}) {
   return sharedPref.remove(key);
  }
}
