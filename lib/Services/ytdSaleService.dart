import 'dart:convert';
import 'package:sale_order_app/Models/ytdSale.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:http/http.dart' as http;

class YTDSaleService {
  
  Future<APIResponce<List<YTDSale>>> getYTDSaleList() async {
    var ytdSaleListItems;
    var data;
    try {
      print("Link called in saleorder service = " +
          APIConstants.baseUrlMain +
          APIConstants.ytdSaleListApi);
      data =
          await http.get(APIConstants.baseUrlMain + APIConstants.ytdSaleListApi);

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in YTD sale service: $jsonDataasMap");

        ytdSaleListItems = <YTDSale>[];
        for (var i in jsonDataasMap) {
          YTDSale ytdSale = YTDSale.fromJson(i);
          print(
              "responce body in in YTD sale service item by item  : ${ytdSale.month}");
          ytdSaleListItems.add(ytdSale);
        }

        print("List items : ${ytdSaleListItems.length}");
        return APIResponce<List<YTDSale>>(data: ytdSaleListItems);
      }

      // return APIResponce<List<SaleOrder>>(
      //     error: true,
      //     data: doListItems,
      //     errorMessage: "An error occured in SO service class !!!!!");
    } catch (_) {
      print("Link called in saleorder service = " +
          APIConstants.baseUrlCompany +
          APIConstants.ytdSaleListApi);
      data = await http
          .get(APIConstants.baseUrlCompany + APIConstants.ytdSaleListApi);

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in YTD sale service : $jsonDataasMap");

        ytdSaleListItems = <YTDSale>[];
        for (var i in jsonDataasMap) {
          YTDSale ytdSale = YTDSale.fromJson(i);
          print(
              "responce body in YTD sale service item by item  : ${ytdSale.month}");
          ytdSaleListItems.add(ytdSale);
        }

        print("List items : ${ytdSaleListItems.length}");
        return APIResponce<List<YTDSale>>(data: ytdSaleListItems);
      }
    }

    return APIResponce<List<YTDSale>>(
        error: true,
        data: ytdSaleListItems,
        errorMessage: "An error occured in YTD sale service class !!!!!");
  }

 
}
