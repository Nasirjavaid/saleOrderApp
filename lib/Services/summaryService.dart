import 'dart:convert';

import 'package:sale_order_app/Models/sammury.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:http/http.dart' as http;
import 'package:sale_order_app/config/constents.dart';

class SummaryService {
  Future<APIResponce<Summary>> getSammury() async {
    Summary sammury = Summary();



    var data = await  http.get(APIConstants.dashboardSummaryApi).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        print("Time out Called in Delivery order service");
        return null;
      },
    );

    
    // print("responce body in Summary service : ${jsonDataasMap}");

    if (data != null) {
      if (data.statusCode == 110) {
        return APIResponce<Summary>(data: sammury);
      }

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in Summary service : ${jsonDataasMap}");

        sammury = Summary.fromJson(jsonDataasMap);

        print("responce body in Summary service : ${sammury.mTD}");
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
