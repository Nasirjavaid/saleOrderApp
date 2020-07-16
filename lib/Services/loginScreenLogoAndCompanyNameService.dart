import 'dart:convert';
import 'package:sale_order_app/Models/loginScreenlogoAndCompanyName.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:http/http.dart' as http;

class LoginScreenLogoAndCompanyNameService {
  var data;
  Future<APIResponce<LoginScreenLogoAndComapnyName>>
      getLoginScreenLogoAndCompanyName() async {
    try {
      print("Url called in Logo and company name =" +
          APIConstants.baseUrlMain +
          APIConstants.loginScreenLogoAndCompantNameApi);
      data = await http.get(APIConstants.baseUrlMain +
          APIConstants.loginScreenLogoAndCompantNameApi);

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        LoginScreenLogoAndComapnyName loginScreenLogoAndComapnyName;
        for (var item in jsonDataasMap) {
          print("responce body in  loginScreenLogoAndComapnyName : ${item}");

          loginScreenLogoAndComapnyName =
              LoginScreenLogoAndComapnyName.fromJson(item);

          print(
              "responce body in  loginScreenLogoAndComapnyName : ${loginScreenLogoAndComapnyName.companyName}");
        }

        return APIResponce<LoginScreenLogoAndComapnyName>(
            data: loginScreenLogoAndComapnyName);
      }
    } catch (_) {
      print("Url called in Logo and company name =" +
          APIConstants.baseUrlCompany +
          APIConstants.loginScreenLogoAndCompantNameApi);

      data = await http.get(APIConstants.baseUrlCompany +
          APIConstants.loginScreenLogoAndCompantNameApi);

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        LoginScreenLogoAndComapnyName loginScreenLogoAndComapnyName;
        for (var item in jsonDataasMap) {
          print("responce body in  loginScreenLogoAndComapnyName : ${item}");

          loginScreenLogoAndComapnyName =
              LoginScreenLogoAndComapnyName.fromJson(item);

          print(
              "responce body in  loginScreenLogoAndComapnyName : ${loginScreenLogoAndComapnyName.companyName}");
        }

        return APIResponce<LoginScreenLogoAndComapnyName>(
            data: loginScreenLogoAndComapnyName);
      }
    }

    return APIResponce<LoginScreenLogoAndComapnyName>(
        error: true,
        errorMessage: "An error occured in SO service class !!!!!");
    // })
    // .catchError((Object exception) => APIResponce<
    //         LoginScreenLogoAndComapnyName>(
    //     error: true,
    //     errorMessage:
    //         "An error occured in sale order services class :: $exception"))
    // .timeout(Duration(seconds: 6))
    // .then((value) => APIResponce<LoginScreenLogoAndComapnyName>(
    //     error: true, errorMessage: "An Time error"));
  }
}
