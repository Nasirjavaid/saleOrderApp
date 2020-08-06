import 'dart:convert';

import 'package:sale_order_app/Models/user.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:http/http.dart' as http;
import 'package:sale_order_app/config/constents.dart';

class UserService {
  User user = User();

  var data;
  Future<APIResponce<User>> getUserAuth(
      String userName, String password) async {
    print("Login url called = " +
        APIConstants.baseUrlMain +
        APIConstants.userAuthApi);
    try {
      data = await http
          .get(APIConstants.baseUrlMain +
              APIConstants.userAuthApi +
              
              userName +
              "/" +
              password)
          .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          // time has run out, do what you wanted to do
          print("Time out called ----====--- ::::  ");
          return null;
        },
      );
    } catch (_) {
      print("Login url called = " +
          APIConstants.baseUrlCompany +
          APIConstants.userAuthApi);
      data = await http
          .get(APIConstants.baseUrlCompany +
              APIConstants.userAuthApi +
            
              userName +
              "/" +
              password)
          .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          // time has run out, do what you wanted to do
          print("Time out called ----====--- ::::  ");
          return null;
        },
      );
    }

    // print("User auth responce ${data.body}");

    if (data != null) {
      if (data.statusCode == 110) {
        return APIResponce<User>(data: user);
      }

      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);

        user = User.fromJson(jsonDataasMap);
        print(
            "User auth api called :'in services' ${user.userId} :  ${user.userId}");
        return APIResponce<User>(data: user);
      }
    }

    return APIResponce<User>(
        data: user,
        error: true,
        errorMessage: "An error occured in User services class !!!!!");
  }
}
