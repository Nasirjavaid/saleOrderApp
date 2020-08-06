import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Constents {
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
      TextStyle(color: Colors.white70, fontWeight: FontWeight.bold);

  static TextStyle mainHeadingTextStyle =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white);
}

class AppColorsStyles {
  static Color mainColorAscent = Colors.yellow;
}

class APIConstants {
  
  static String baseUrlCompany = "http://192.168.88.101:1500";
  static String baseUrlMain = "http://27.255.29.138:1500";
  static String userAuthApi = "/api/login/";
  static String dashboardSummaryApi = "/api/summary";
  static String deliveryChallanApi = "/api/deliverychallan";
  static String saleOrderyApi = "/api/saleorder";
  static String deliveryOrderStatusUpdateApi = "/api/UpdateDC";
  static String saleOrderStatusUpdateApi = "/api/UpdateSO";
  static String loginScreenLogoAndCompantNameApi ="/api/MainScreen?companyId=1";
}

class AppColours {
  static Color backgroundColorForApp = Color.fromRGBO(58, 66, 86, 1.0);
  static Color backgroundColorForCards = Color.fromRGBO(64, 75, 96, .9);
}

enum ViewState { Idle, Busy, Retrieved, Error }

class DateTimeConverter {
  String getDateAndTime(String rawDateAndTime) {
    var rawDate = DateTime.tryParse(rawDateAndTime);
    var formatter = new DateFormat.yMd().add_jm();
    String formatted = formatter.format(rawDate);

    return formatted;
  }
}
