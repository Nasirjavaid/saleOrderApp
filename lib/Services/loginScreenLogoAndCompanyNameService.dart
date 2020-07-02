import 'dart:convert';
import 'package:sale_order_app/Models/loginScreenlogoAndCompanyName.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:http/http.dart' as http;

class LoginScreenLogoAndCompanyNameService {
  Future<APIResponce<LoginScreenLogoAndComapnyName>>
      getLoginScreenLogoAndCompanyName() async {
   final data = await http.get(APIConstants.loginScreenLogoAndCompantNameApi);

        
          if (data.statusCode == 200) {
            final jsonDataasMap = json.decode(data.body);
            LoginScreenLogoAndComapnyName loginScreenLogoAndComapnyName;
            for (var item in jsonDataasMap) {
              print(
                  "responce body in  loginScreenLogoAndComapnyName : ${item}");

              loginScreenLogoAndComapnyName =
                  LoginScreenLogoAndComapnyName.fromJson(item);

              print(
                  "responce body in  loginScreenLogoAndComapnyName : ${loginScreenLogoAndComapnyName.companyName}");
            }

            return APIResponce<LoginScreenLogoAndComapnyName>(
                data: loginScreenLogoAndComapnyName);
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
