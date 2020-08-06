import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sale_order_app/Services/LoginScreenlogoAndCompanyNameService.dart';
import 'package:sale_order_app/Services/deliveryChallanService.dart';
import 'package:sale_order_app/Services/saleOrderService.dart';
import 'package:sale_order_app/Services/summaryService.dart';
import 'package:sale_order_app/Services/userServise.dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/config/darkThemePrefrences.dart';
import 'package:sale_order_app/ui/Screens/HomeScreen/dashBoard.dart';
import 'package:sale_order_app/ui/Screens/LoginScreen/loginScreen.dart';
import 'config/appState.dart';

void setUpLocator() {
  GetIt.I.registerLazySingleton(() => UserService());
  GetIt.I.registerLazySingleton(() => SummaryService());
  GetIt.I.registerLazySingleton(() => SOService());
  GetIt.I.registerLazySingleton(() => DCService());
  GetIt.I.registerLazySingleton(() => LoginScreenLogoAndCompanyNameService());
}

void main() async {
  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();
//Set up locator function
  setUpLocator();
  // Set default home.
  Widget _defaultHome = new LoginScreen();
  LoginPrefrences loginPrefrences = LoginPrefrences();

  // Get result of the login function.
  int _result = await loginPrefrences.getUser();
  if (_result != 0) {
    print(
        "User id in main file to check if we need to login or go to Dashboard = $_result");
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
