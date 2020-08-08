import 'dart:convert';
import 'package:sale_order_app/Models/sammury.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:http/http.dart' as http;
import 'package:sale_order_app/config/constents.dart';

class SummaryService {
  var data;
  Future<APIResponce<Summary>> getSammury() async {
    Summary sammury = Summary();

    try {
      print("Api called in Summary service  = "+APIConstants.baseUrlMain + APIConstants.dashboardSummaryApi);
      data = await http
          .get(APIConstants.baseUrlMain+APIConstants.dashboardSummaryApi)
          .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          print(
              "Time out Called in Delivery order service ${APIConstants.dashboardSummaryApi}");
          return null;
        },
      );
    } catch (_) {
      print("Api called in Summary service  = http://192.168.88.101:1500" + APIConstants.dashboardSummaryApi);
      data = await http
          .get(APIConstants.baseUrlCompany + APIConstants.dashboardSummaryApi)
          .timeout(Duration(seconds: 10), onTimeout: () {
        print(
            "Time out Called in Delivery order service ${APIConstants.dashboardSummaryApi}");
        return null;
      });
    }

    // print("responce body in Summary service : ${jsonDataasMap}");

    if (data != null) {
      if (data.statusCode == 110) {
        return APIResponce<Summary>(data: sammury);
      }

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in Summary service : $jsonDataasMap");

        sammury = Summary.fromJson(jsonDataasMap);

        print("responce body in Summary service : ${sammury.mtd}");
        return APIResponce<Summary>(data: sammury);
      }
    }

    // if(data == null)
    // {
    //   return null;
    // }

    return APIResponce<Summary>(
        error: true,
        data: null,
        errorMessage: "An error occured in Sammury services class !!!!!");
  }
}
