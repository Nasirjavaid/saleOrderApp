import 'package:flutter/material.dart';
import 'package:sale_order_app/config/darkThemePrefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';


  // DarkThemePreference darkThemePreference = DarkThemePreference();
  // bool _darkTheme = false;

  // bool get darkTheme => _darkTheme;

  // set darkTheme(bool value) {
  //   _darkTheme = value;
  //   darkThemePreference.setDarkTheme(value);
  //   notifyListeners();
  // }

class AppState with ChangeNotifier {
  // bool _isDarkModeOn = false;

  // bool get darkTheme  => _isDarkModeOn;

  // set darkTheme(bool isDarkModeOn)  {
  //    this._isDarkModeOn = isDarkModeOn;
  //   setColorPrefrences(isDarkModeOn);
  //  // this.isDarkModeOn = await getColorPrefrences();

  //   print("current valu of preff $isDarkModeOn");
  //   notifyListeners();
  // }


  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  
  }

  Future<void> setColorPrefrences(bool moodValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("Value updated in pref,,$moodValue");
    preferences.setBool("mood", moodValue);

    preferences.commit();
    notifyListeners();
  }

  Future<bool> getColorPrefrences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //print("getting value from fref ,,");

    bool myValue = preferences.getBool("mood");
    print("bool value in my value  ,, $myValue");
    notifyListeners();
    return myValue ?? false;
  }

  //



  //  DarkThemePreference darkThemePreference = DarkThemePreference();
  // bool _darkTheme = false;

  // bool get darkTheme => _darkTheme;

  // set darkTheme(bool value) {
  //   _darkTheme = value;
  //   darkThemePreference.setDarkTheme(value);
  //   notifyListeners();
  // }
}


