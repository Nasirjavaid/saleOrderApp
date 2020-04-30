import 'dart:convert';

import 'package:sale_order_app/Models/deliveryOrder.dart';

import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:http/http.dart' as http;
import 'package:sale_order_app/config/constents.dart';

class DOService {
  Future<APIResponce<List<DeliveryOrder>>> getDoList() async {
    

  
   
      return http.get(APIConstants.deliveryOrderyApi).then((data) {
        if (data.statusCode == 200) {
          final jsonDataasMap = json.decode(data.body);
          print("responce body in Do service : ${jsonDataasMap}");

          final doListItems = <DeliveryOrder>[];
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
            errorMessage: "An error occured in DO service class !!!!!");
      }).catchError((Object exception) => APIResponce<List<DeliveryOrder>>(
          error: true,
          errorMessage: "An error occured in Delivery order services class :: $exception"));
   
  }
}
