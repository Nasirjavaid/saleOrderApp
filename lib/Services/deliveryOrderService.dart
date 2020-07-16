import 'dart:convert';
import 'package:sale_order_app/Models/deliveryOrder.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:http/http.dart' as http;
import 'package:sale_order_app/config/constents.dart';

class DOService {
  Future<APIResponce<List<DeliveryOrder>>> getDoList() async {
    var doListItems;
    var data;

    try {
      print("Link called in sale order = " +
          APIConstants.baseUrlMain +
          APIConstants.deliveryOrderyApi);
      data = await http
          .get(APIConstants.baseUrlMain + APIConstants.deliveryOrderyApi);

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in Do service : ${jsonDataasMap}");

        doListItems = <DeliveryOrder>[];
        for (var item in jsonDataasMap) {
          DeliveryOrder deliveryOrder = DeliveryOrder.fromJson(item);
          print("${deliveryOrder.balance}");
          print("${deliveryOrder.limit}");
          print("${deliveryOrder.date}");
          doListItems.add(deliveryOrder);
        }

        return APIResponce<List<DeliveryOrder>>(data: doListItems);
      }

      return APIResponce<List<DeliveryOrder>>(
          error: true,
          data: doListItems,
          errorMessage: "An error occured in DO service class !!!!!");
    } catch (_) {
      print("Link called in sale order = " +
          APIConstants.baseUrlCompany +
          APIConstants.deliveryOrderyApi);
      data = await http
          .get(APIConstants.baseUrlCompany + APIConstants.deliveryOrderyApi);

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in Do service : ${jsonDataasMap}");

        doListItems = <DeliveryOrder>[];
        for (var item in jsonDataasMap) {
          DeliveryOrder deliveryOrder = DeliveryOrder.fromJson(item);
          print("${deliveryOrder.balance}");
          print("${deliveryOrder.limit}");
          print("${deliveryOrder.date}");
          doListItems.add(deliveryOrder);
        }

        return APIResponce<List<DeliveryOrder>>(data: doListItems);
      }
    }

    return APIResponce<List<DeliveryOrder>>(
        error: true,
        data: doListItems,
        errorMessage: "An error occured in DO service class !!!!!");
  }

  Future<APIResponce<bool>> updateDeliveryOrderStatus(
      int doId, int stuatus) async {
    var data;
    try {
      print("link called in delivery order status change = " +
          APIConstants.baseUrlMain +
          APIConstants.deliveryOrderStatusUpdateApi);
      data = await http.get(APIConstants.baseUrlMain +
          APIConstants.deliveryOrderStatusUpdateApi +
          "doID=$doId&status=$stuatus");
      print("body text in Delivery Order status update service  ${data.body}");
      if (data.statusCode == 200) {
        print(
            "body text in Delivery Order status update service  ${data.body}");

        final jsonDataasMap = json.decode(data.body);
        return APIResponce<bool>(data: jsonDataasMap);
      }
    } catch (_) {
      
      print("link called in delivery order status change = " +
          APIConstants.baseUrlCompany +
          APIConstants.deliveryOrderStatusUpdateApi);

      data = await http.get(APIConstants.baseUrlCompany +
          APIConstants.deliveryOrderStatusUpdateApi +
          "doID=$doId&status=$stuatus");
      print("body text in Delivery Order status update service  ${data.body}");
      if (data.statusCode == 200) {
        print(
            "body text in Delivery Order status update service  ${data.body}");

        final jsonDataasMap = json.decode(data.body);
        return APIResponce<bool>(data: jsonDataasMap);
      }
    }

    return APIResponce<bool>(
        data: false,
        error: true,
        errorMessage:
            "An error occured while subbmiting data in delivery order update status");
  }
}
