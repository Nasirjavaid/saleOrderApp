import 'dart:convert';
import 'package:sale_order_app/Models/loginScreenlogoAndCompanyName.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:http/http.dart' as http;

class LoginScreenLogoAndCompanyNameService {
  Future<APIResponce<LoginScreenLogoAndComapnyName>>
      getLoginScreenLogoAndCompanyName() async {
    return http.get(APIConstants.loginScreenLogoAndCompantNameApi).then((data) {
      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);

        print(
            "responce body in  loginScreenLogoAndComapnyName : ${jsonDataasMap}");

        LoginScreenLogoAndComapnyName loginScreenLogoAndComapnyName =
            LoginScreenLogoAndComapnyName.fromJson(jsonDataasMap);

        return APIResponce<LoginScreenLogoAndComapnyName>(
            data: loginScreenLogoAndComapnyName);
      }

      return APIResponce<LoginScreenLogoAndComapnyName>(
          error: true,
          errorMessage: "An error occured in SO service class !!!!!");
    }).catchError((Object exception) =>
        APIResponce<LoginScreenLogoAndComapnyName>(
            error: true,
            errorMessage:
                "An error occured in sale order services class :: $exception"));
  }
}
