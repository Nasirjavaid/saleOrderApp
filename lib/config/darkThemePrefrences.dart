import 'package:sale_order_app/Models/user.dart';
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

  setUser(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("User sent value && user id here $userId");
    prefs.setInt(USER_STATUS, userId);
   // prefs.setBool(USER_STATUS, value);
  }

  Future<int> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(USER_STATUS) ?? 0;
  }
}
