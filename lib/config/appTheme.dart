import 'package:flutter/material.dart';

class AppTheme {



static Color appBackgroundColor =Color(0xFF42CCC8);
static Color appBackgroundColorforCard1 =Color(0xFF4C98CF);
static Color appBackgroundColorforCard2 =Color(0xFF4873A6);
static Color appBackgroundColorforCard3 =Color(0xFF5A5387);
static Color appBackgroundColorforCard4 =Color(0xFF524365);


static Color appBackgroundColorforCard5 =Color(0xFF2193b0);

static Color appBackgroundColorForButtons =Color(0xFF3A4F73);




  AppTheme._();

  static Color _iconColor = Colors.blueAccent.shade200;

  static const Color _lightPrimaryColor = Colors.white;
  static const Color _lightPrimaryVariantColor = Color(0XFFE1E1E1);
  static const Color _lightSecondaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.black;

  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryVariantColor,
    appBarTheme: AppBarTheme(
      color: _lightPrimaryVariantColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
      background: Colors.white
    
    ),
    iconTheme: IconThemeData(
      color: _iconColor,
    ),
    textTheme: _lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryVariantColor,
    appBarTheme: AppBarTheme(
      color: _darkPrimaryVariantColor,
      iconTheme: IconThemeData(color: _darkOnPrimaryColor),
    ),
    colorScheme: ColorScheme.light(
      primary: _darkPrimaryColor,
      primaryVariant: _darkPrimaryVariantColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
      background: Colors.black
    ),
    iconTheme: IconThemeData(
      color: _iconColor,
    ),
    textTheme: _darkTextTheme,
  );

  static final TextTheme _lightTextTheme = TextTheme(

    display1: _lightScreenTextStyleDisplay1,
    display2: _lightScreenTextStyleDisplay2,
    display3: _lightScreenTextStyleDisplay3,
    display4: _lightScreenTextStyleDisplay4,
    headline: _lightScreenTextStyleHeadline,
    title: _lightScreenTextStyleTitle,
    subhead: _lightScreenTextStyleSubhead,
    body2: _lightScreenTextStyleBody2,
    body1: _lightScreenTextStyleBody1,
    caption: _lightScreenTextStyleCaption,
    button: _lightScreenTextStyleButton,
    subtitle: _lightScreenTextStyleSubTitle,
    overline: _lightScreenTextStyleSubOverLine
  );

  static final TextTheme _darkTextTheme = TextTheme(
     display1: _darkScreenTextStyleDisplay1,
    display2: _darkScreenTextStyleDisplay2,
    display3: _darkScreenTextStyleDisplay3,
    display4: _darkScreenTextStyleDisplay4,
    headline: _darkScreenTextStyleHeadline,
    title: _darkScreenTextStyleTitle,
    subhead: _darkScreenTextStyleSubhead,
    body2: _darkScreenTextStyleBody2,
    body1: _darkScreenTextStyleBody1,
    caption: _darkScreenTextStyleCaption,
    button: _darkScreenTextStyleButton,
    subtitle: _darkScreenTextStyleSubTitle,
    overline: _darkScreenTextStyleSubOverLine
    
  );


/// Suggested  BY Material design 
/// NAME       SIZE   WEIGHT   SPACING  2018 NAME
/// display4   112.0  thin     0.0      headline1
/// display3   56.0   normal   0.0      headline2
/// display2   45.0   normal   0.0      headline3
/// display1   34.0   normal   0.0      headline4
/// headline   24.0   normal   0.0      headline5
/// title      20.0   medium   0.0      headline6
/// subhead    16.0   normal   0.0      subtitle1
/// body2      14.0   medium   0.0      body1
/// body1      14.0   normal   0.0      body2
/// caption    12.0   normal   0.0      caption
/// button     14.0   medium   0.0      button
/// subtitle   14.0   medium   0.0      subtitle2
/// overline   10.0   normal   0.0      overline
/// 
/// 
/// 
/// 
/// For light theme
/// by writer 
/// static final TextStyle _lightScreenHeadingTextStyle = TextStyle(fontSize: 48.0, color: _lightOnPrimaryColor);
/// static final TextStyle _lightScreenTaskNameTextStyle = TextStyle(fontSize: 20.0, color: _lightOnPrimaryColor);
/// static final TextStyle _lightScreenTaskDurationTextStyle = TextStyle(fontSize: 16.0, color: Colors.grey);
  
//By me
 static final TextStyle _lightScreenTextStyleDisplay1  = TextStyle(fontSize: 34.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleDisplay2  = TextStyle(fontSize: 45.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleDisplay3  = TextStyle(fontSize: 56.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleDisplay4  = TextStyle(fontSize: 112.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleHeadline  = TextStyle(fontSize: 24.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleTitle  = TextStyle(fontSize: 20.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleSubhead  = TextStyle(fontSize: 16.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleBody1  = TextStyle(fontSize: 11.0, color: Colors.black54);
 static final TextStyle _lightScreenTextStyleBody2  = TextStyle(fontSize: 14.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleCaption  = TextStyle(fontSize: 12.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleButton  = TextStyle(fontSize: 14.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleSubTitle  = TextStyle(fontSize: 14.0, color: _lightOnPrimaryColor);
 static final TextStyle _lightScreenTextStyleSubOverLine  = TextStyle(fontSize: 10.0, color: _lightOnPrimaryColor);
//



/// For dark theme
//by writer 
  // static final TextStyle _darkScreenHeadingTextStyle = _lightScreenHeadingTextStyle.copyWith(color: _darkOnPrimaryColor);
  // static final TextStyle _darkScreenTaskNameTextStyle = _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);
  // static final TextStyle _darkScreenTaskDurationTextStyle = _lightScreenTaskDurationTextStyle;


  //By me
 static final TextStyle _darkScreenTextStyleDisplay1  = TextStyle(fontSize: 34.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleDisplay2  = TextStyle(fontSize: 45.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleDisplay3  = TextStyle(fontSize: 56.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleDisplay4  = TextStyle(fontSize: 112.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleHeadline  = TextStyle(fontSize: 24.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleTitle  = TextStyle(fontSize: 20.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleSubhead  = TextStyle(fontSize: 16.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleBody1  = TextStyle(fontSize: 11.0, color:Colors.white70);
 static final TextStyle _darkScreenTextStyleBody2  = TextStyle(fontSize: 14.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleCaption  = TextStyle(fontSize: 12.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleButton  = TextStyle(fontSize: 14.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleSubTitle  = TextStyle(fontSize: 14.0, color: _darkOnPrimaryColor);
 static final TextStyle _darkScreenTextStyleSubOverLine  = TextStyle(fontSize: 10.0, color: _darkOnPrimaryColor);
//
}