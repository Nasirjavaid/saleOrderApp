import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

class LoginPrefrences {

  static const USER_STATUS = "user";

  setUser(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("User sent value $value");
    prefs.setBool(USER_STATUS, value);
  }

  Future<bool> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(USER_STATUS) ?? false;
  }
}

