import 'dart:convert';

import 'package:sale_order_app/Models/user.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:http/http.dart' as http;
import 'package:sale_order_app/config/constents.dart';

class UserService {
  User user = User();
  Future<APIResponce<User>> getUserAuth() async {
   
      return http.get(APIConstants.userAuthApi).then((data) {
        if (data.statusCode == 200) {
          final jsonDataasMap = json.decode(data.body);

          user = User.fromJson(jsonDataasMap);
          print("User auth api called :'in services' ${user.authenticatoin} :  ${user.response}");
          return APIResponce<User>(data: user);
        }

        return APIResponce<User>(
            error: true,
            errorMessage: "An error occured in User services class !!!!!");
      }).catchError((Object exception) => APIResponce<User>(
           error: true,
          errorMessage: "An error occured in sale order services class :: $exception"));
    
  }
}
