import 'dart:convert';
import 'package:sale_order_app/Models/saleOrder.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:http/http.dart' as http;

class SOService {
  var doListItems ;
  Future<APIResponce<List<SaleOrder>>> getSoList() async {
    return http.get(APIConstants.saleOrderyApi).then((data) {
      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in SO service : ${jsonDataasMap}");

        doListItems = <SaleOrder>[];
        for (var i in jsonDataasMap) {
          SaleOrder deliveryOrder = SaleOrder.fromJson(i);
    print("responce body in SO service item by item  : ${deliveryOrder.balance_}");
          doListItems.add(deliveryOrder);
        }

        print("List items : ${doListItems.length}");
        return APIResponce<List<SaleOrder>>(data: doListItems);
      }

      return APIResponce<List<SaleOrder>>(
          error: true,
          data: doListItems,
          errorMessage: "An error occured in SO service class !!!!!");
    }).catchError((Object exception) => APIResponce<List<SaleOrder>>(
        error: true,
        errorMessage:
            "An error occured in sale order services class :: $exception")) .timeout(
          Duration(seconds: 10),
          onTimeout: () {
            print("Time out Called in Sale order order service");
            return null;
          },
        );
  }


  Future<APIResponce<bool>> updateSaleOrderStatus(
      int soId, int stuatus) async {
    final data = await http.get(APIConstants.saleOrderStatusUpdateApi +
        "soID=$soId&status=$stuatus");

         print("body text in Sale Order status update service  ${data.body}");

    if (data.statusCode == 200) {
      print(" body text in Sale Order status update service  ${data.body}");

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
        errorMessage: "An error occured while subbmiting data in sale order update status");
  }
}
