import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static const _keyLogin = 'isLogin';

  static Future<void> setLogin(bool value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_keyLogin, value);
  }

  static Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_keyLogin) ?? false;
  }

  static Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
