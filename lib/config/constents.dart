import 'package:intl/intl.dart';


import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constents{


// Number formater
  static var numbaerFormate = new NumberFormat("#,##0", "en_US");
}





/*
Styles for typography
*/

// TO DO : Finalize Font Family for the app
class AppTypographyStyles {
  static TextStyle titleTextStyle = TextStyle(
      color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 12);

  static TextStyle smallTextStyle = TextStyle(
    color: Colors.white60,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static TextStyle smallTextStyleNotVailable = TextStyle(
      color: Color.fromRGBO(107, 125, 135, .9),
      fontWeight: FontWeight.bold,
      fontSize: 13);

  static TextStyle headingTextStyle =
      TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold);

  static TextStyle mainHeadingTextStyle = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white);
}

// TO DO : Finalize Font Family for the app
class AppColorsStyles {
  static Color mainColorAscent = Colors.yellow;
}

class APIConstants {
static String userAuthApi ="http://95.168.178.226/SOAPP/login.json"; 
 static String dashboardSummaryApi ="http://95.168.178.226/SOAPP/summary.json"; 
 static String deliveryOrderyApi ="http://95.168.178.226/SOAPP/deliveryorder.json"; 
 static String saleOrderyApi ="http://95.168.178.226/SOAPP/saleorder.json"; 
 static String loginScreenLogoAndCompantNameApi ="http://95.168.178.226/SOAPP/MainScreen.json"; 


}

class AppColours {
  static Color backgroundColorForApp = Color.fromRGBO(58, 66, 86, 1.0);
  static Color backgroundColorForCards = Color.fromRGBO(64, 75, 96, .9);
}

enum ViewState { Idle, Busy, Retrieved, Error }



class DateTimeConverter {
 static String getDateAndTime(String rawDateAndTime) {
    var rawDate = DateTime.tryParse(rawDateAndTime);
    var formatter = new DateFormat.yMd().add_jm();
    String formatted = formatter.format(rawDate);

    return formatted;
  }
}
