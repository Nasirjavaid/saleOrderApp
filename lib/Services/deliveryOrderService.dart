import 'dart:convert';
import 'package:sale_order_app/Models/deliveryOrder.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:http/http.dart' as http;
import 'package:sale_order_app/config/constents.dart';

class DOService {

  var doListItems ;
  Future<APIResponce<List<DeliveryOrder>>> getDoList() async {
    return http
        .get(APIConstants.deliveryOrderyApi)
        .then((data) {
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
              data:doListItems,
              errorMessage: "An error occured in DO service class !!!!!");
        })
        .catchError((Object exception) => APIResponce<List<DeliveryOrder>>(
            error: true,
            errorMessage:
                "An error occured in Delivery order services class :: $exception"))
        .timeout(
          Duration(seconds: 10),
          onTimeout: () {
            print("Time out Called in Delivery order service");
            return null;
          },
        );
  }

  Future<APIResponce<bool>> updateDeliveryOrderStatus(
      int doId, int stuatus) async {
    final data = await http.get(APIConstants.deliveryOrderStatusUpdateApi +
        "doID=$doId&status=$stuatus");
  print("body text in Delivery Order status update service  ${data.body}");
    if (data.statusCode == 200) {
      print("body text in Delivery Order status update service  ${data.body}");

      final jsonDataasMap = json.decode(data.body);

      // for (var i in jsonDataasMap) {

      //   familyModel =Family.fromJson(i);
      //   print(
      //       "Family name  ${familyModel.familyName} and family id  ${familyModel.familyId}");
      // }
      return APIResponce<bool>(data: jsonDataasMap);
    }

    return APIResponce<bool>(
        data: false,
        error: true,
        errorMessage: "An error occured while subbmiting data in delivery order update status");
  }
}
