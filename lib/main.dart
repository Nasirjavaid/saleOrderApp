import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/config/darkThemePrefrences.dart';
import 'package:sale_order_app/ui/Screens/HomeScreen/dashBoard.dart';

import 'package:sale_order_app/ui/Screens/LoginScreen/loginScreen.dart';

import 'config/appState.dart';

void main() async {
  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();

  // Set default home.
  Widget _defaultHome = new LoginScreen();
  LoginPrefrences loginPrefrences = LoginPrefrences();

  // Get result of the login function.
  bool _result = await loginPrefrences.getUser();
  if (_result) {
    _defaultHome = new Dashboard();
  } 


  // Run app!
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new Dashboard(),
      '/login': (BuildContext context) => new LoginScreen()
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppState myAppState = AppState();

  getCurrentAppTheme() async {
    myAppState.darkTheme = await myAppState.darkThemePreference.getTheme();

    print("Prefrence value in main ${myAppState.darkTheme}");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) {
      return myAppState;
    }, child: Consumer<AppState>(builder: (context, appState, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appState.darkTheme ? ThemeMode.dark : ThemeMode.light,
        home: Dashboard(),
      );
    }));
  }
}
// bool getUserInSplash() {
//   loginPrefrences.getUser().then((val) {
//     print(val);
//     return val;
//   });

//   return false;
// }
