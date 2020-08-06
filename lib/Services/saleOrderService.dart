import 'dart:convert';
import 'package:sale_order_app/Models/saleOrder.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:http/http.dart' as http;

class SOService {
  Future<APIResponce<List<SaleOrder>>> getSoList() async {
    var doListItems;
    var data;
    try {
      print("Link called in saleorder service = " +
          APIConstants.baseUrlMain +
          APIConstants.saleOrderyApi);
      data =
          await http.get(APIConstants.baseUrlMain + APIConstants.saleOrderyApi);

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in SO service : ${jsonDataasMap}");

        doListItems = <SaleOrder>[];
        for (var i in jsonDataasMap) {
          SaleOrder deliveryOrder = SaleOrder.fromJson(i);
          print(
              "responce body in SO service item by item  : ${deliveryOrder.balanceAfterSo}");
          doListItems.add(deliveryOrder);
        }

        print("List items : ${doListItems.length}");
        return APIResponce<List<SaleOrder>>(data: doListItems);
      }

      // return APIResponce<List<SaleOrder>>(
      //     error: true,
      //     data: doListItems,
      //     errorMessage: "An error occured in SO service class !!!!!");
    } catch (_) {
      print("Link called in saleorder service = " +
          APIConstants.baseUrlCompany +
          APIConstants.saleOrderyApi);
      data = await http
          .get(APIConstants.baseUrlCompany + APIConstants.saleOrderyApi);

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in SO service : ${jsonDataasMap}");

        doListItems = <SaleOrder>[];
        for (var i in jsonDataasMap) {
          SaleOrder deliveryOrder = SaleOrder.fromJson(i);
          print(
              "responce body in SO service item by item  : ${deliveryOrder.balanceAfterSo}");
          doListItems.add(deliveryOrder);
        }

        print("List items : ${doListItems.length}");
        return APIResponce<List<SaleOrder>>(data: doListItems);
      }
    }

    return APIResponce<List<SaleOrder>>(
        error: true,
        data: doListItems,
        errorMessage: "An error occured in SO service class !!!!!");
  }

  Future<APIResponce<bool>> updateSaleOrderStatus(int soId, int stuatus,int userId) async {
    var data;

    try {
      print("Link called in sale status update service " +
          APIConstants.baseUrlMain +
          APIConstants.saleOrderStatusUpdateApi);
      data = await http.get(APIConstants.baseUrlMain +
          APIConstants.saleOrderStatusUpdateApi +
          "/$soId/$stuatus/$userId");

      print("body text in Sale Order status update service  ${data.body}");

      if (data.statusCode == 200) {
        print(" body text in Sale Order status update service  ${data.body}");

        final jsonDataasMap = json.decode(data.body);
        return APIResponce<bool>(data: jsonDataasMap);
      }
    } catch (_) {
      print("Link called in sale status update service " +
          APIConstants.baseUrlCompany +
          APIConstants.saleOrderStatusUpdateApi);
      data = await http.get(APIConstants.baseUrlCompany +
          APIConstants.saleOrderStatusUpdateApi +
          "soID=$soId&status=$stuatus");

      print("body text in Sale Order status update service  ${data.body}");

      if (data.statusCode == 200) {
        print(" body text in Sale Order status update service  ${data.body}");

        final jsonDataasMap = json.decode(data.body);
        return APIResponce<bool>(data: jsonDataasMap);
      }
    } 
    return APIResponce<bool>(
        data: false,
        error: true,
        errorMessage:
            "An error occured while subbmiting data in sale order update status");
  }
}
