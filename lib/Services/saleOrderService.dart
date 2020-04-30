import 'dart:convert';
import 'package:sale_order_app/Models/saleOrder.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:http/http.dart' as http;

class SOService {
  Future<APIResponce<List<SaleOrder>>> getSoList() async {
    return http.get(APIConstants.saleOrderyApi).then((data) {
      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in SO service : ${jsonDataasMap}");

        final doListItems = <SaleOrder>[];
        for (var item in jsonDataasMap) {
          SaleOrder deliveryOrder = SaleOrder.fromJson(item);

          doListItems.add(deliveryOrder);
        }

        return APIResponce<List<SaleOrder>>(data: doListItems);
      }

      return APIResponce<List<SaleOrder>>(
          error: true,
          errorMessage: "An error occured in SO service class !!!!!");
    }).catchError((Object exception) => APIResponce<List<SaleOrder>>(
        error: true,
        errorMessage:
            "An error occured in sale order services class :: $exception"));
  }
}