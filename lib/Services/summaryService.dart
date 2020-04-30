import 'dart:convert';

import 'package:sale_order_app/Models/sammury.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:http/http.dart' as http;
import 'package:sale_order_app/config/constents.dart';

class SummaryService {
  Future<APIResponce<Summary>> getSammury() async {
    Summary sammury = Summary();
   
      return http.get(APIConstants.dashboardSummaryApi).then((data) {
        if (data.statusCode == 200) {
          final jsonDataasMap = json.decode(data.body);
         /// print("responce body in Summary service : ${jsonDataasMap}");
          for (var item in jsonDataasMap) {
            sammury = Summary.fromJson(item);
          }
          print("responce body in Summary service : ${sammury.jan}");
          return APIResponce<Summary>(data: sammury);
        }

        return APIResponce<Summary>(
            error: true,
            errorMessage: "An error occured in Sammury services class !!!!!");
      }).catchError((_) => APIResponce<Summary>(
          error: true,
          errorMessage: "An error occured in Sammury services class !!!!!"));
   
  }
}
