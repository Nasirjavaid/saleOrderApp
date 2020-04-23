import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_order_app/config/appTheme.dart';

import 'package:sale_order_app/ui/Screens/LoginScreen/loginScreen.dart';

import 'config/appState.dart';

void main() => runApp(
      ChangeNotifierProvider<AppState>(
        builder: (context) => AppState(),
        child: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  AppState myAppState = AppState();


  @override
void initState() {
  super.initState();
  getCurrentAppTheme();
}

  getCurrentAppTheme() async {

  
       myAppState.darkTheme =
      await myAppState.darkThemePreference.getTheme();

      print("Prefrence value in main ${myAppState.darkTheme}");
    
 
}
  
  @override
  Widget build(BuildContext context) {

    
    return  ChangeNotifierProvider(
        create: (_) {
          return myAppState;
        },
    
     child:Consumer<AppState>(
      builder: (context, appState, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appState.darkTheme ? ThemeMode.dark : ThemeMode.light,
          home: LoginScreen(),
        );
      },
    ));
  }
}
