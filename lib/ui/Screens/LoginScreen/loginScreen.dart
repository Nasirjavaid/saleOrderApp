import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:sale_order_app/Models/loginScreenlogoAndCompanyName.dart';
import 'package:sale_order_app/Services/loginScreenLogoAndCompanyNameService.dart';
import 'package:sale_order_app/Models/user.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/Services/userServise.dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:sale_order_app/config/darkThemePrefrences.dart';
import 'package:sale_order_app/config/methods.dart';
import 'package:sale_order_app/ui/Screens/HomeScreen/dashBoard.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  //Calling logo and company name service
  LoginScreenLogoAndCompanyNameService
      get loginScreenLogoAndCompanyNameService =>
          GetIt.I<LoginScreenLogoAndCompanyNameService>();
  bool isLoadingForLogoAndName = false;
//Api responce for logo and company name
  APIResponce<LoginScreenLogoAndComapnyName>
      apiResponceLoginScreenLogoAndCompanyName;

  //Getting user service to get User Auth
  UserService get userService => GetIt.I<UserService>();
  //Api responce call for user Auth
  APIResponce<User> apiResponce;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  LoginScreenLogoAndCompanyNameService logiService =
      new LoginScreenLogoAndCompanyNameService();

  TextEditingController etUserNameController = TextEditingController();
  TextEditingController etPasswordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    SystemChannels.textInput.invokeMethod('TextInput.hide');

   // getLoginScreenLogoAndCompanyName();

    super.initState();
  }

  getLoginScreenLogoAndCompanyName() async {
    setState(() {
      isLoadingForLogoAndName = true;
    });

    apiResponceLoginScreenLogoAndCompanyName =
        await logiService.getLoginScreenLogoAndCompanyName();
    print(
        "in  login ++++++++++++  ${apiResponceLoginScreenLogoAndCompanyName.data.companyName}");

    if (apiResponceLoginScreenLogoAndCompanyName.data == null) {
      print("Logo api called");
      if (mounted) {
        setState(() {
          isLoadingForLogoAndName = false;
        });
      }
    }

    if (mounted) {
      setState(() {
        isLoadingForLogoAndName = false;
      });
    }
  }

  Future<bool> fetchUserAuth(String userName, String password) async {
    setState(() {
      isLoading = true;
    });

    apiResponce = await userService.getUserAuth(userName, password);

    if (apiResponce == null) {
      showMessageError("Something went wrong !");

      setState(() {
        isLoading = false;
      });

      return false;
    }

    if (apiResponce.data.userId > 0) {
      // showMessageError("Wrong user name or password !");

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      return true;
    }
    // print("${apiResponce.data.authenticatoin}");
    // print("${apiResponce.data.response}");

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
    return false;
  }

  void showMessageSuccess(String message, [MaterialColor color = Colors.blue]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 1),
    ));
  }

  void showMessageError(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 1),
    ));
  }

  Widget logoAndName() {
    return Builder(
      builder: (BuildContext context) {
        // if (isLoadingForLogoAndName) {
        //   return CommonWidgets.progressIndicator;
        // }

        // if (apiResponceLoginScreenLogoAndCompanyName == null) {
        //   return commonlogoAndNameWidget();
        // }
        return commonlogoAndNameWidget();
      },
    );
  }

  Widget dynaminlogoAndNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(children: <Widget>[
        Container(
            height: 120,
            width: 180,
            child: Image.memory(base64Decode(
                apiResponceLoginScreenLogoAndCompanyName.data.companyLogo))

            //  CachedNetworkImage(
            //     imageUrl:
            //         apiResponceLoginScreenLogoAndCompanyName.data.companyLogo)

            ),
        Text(
          "${apiResponceLoginScreenLogoAndCompanyName.data.companyName}",
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.black87),
        )
      ]),
    );
  }

  Widget commonlogoAndNameWidget() {
    return Column(children: <Widget>[
      Container(
          height: 100,
          child: CachedNetworkImage(
              imageUrl:
                  "https://www.aci.com.pk/images/header/akbari_logo.png",
                  
                  placeholder: (context, url) => Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )),
                            ],
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                  
                  
                  )),

                  SizedBox(height: 20),
      // Padding(
      //   padding: const EdgeInsets.all(25.0),
      //   child: Text("Vision Plus",
      //       style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 40,
      //           fontWeight: FontWeight.w300)),
      //)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      controller: etUserNameController,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,

      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Colors.black54,
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(
            Icons.person,
            size: 22,
            color: Color(0xFF72868a),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: const OutlineInputBorder(
              borderSide: const BorderSide(
                  // color: Color.fromARGB(255, 232, 232, 232),
                  color: Colors.white,
                  width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(
                  // color: Color.fromARGB(255, 232, 232, 232),
                  color: Colors.white,
                  width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(
                  // color: Color.fromARGB(255, 232, 232, 232),
                  color: Colors.white,
                  width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          hintText: "User Name",
          hintStyle:
              TextStyle(color: Color(0xFF72868a), fontWeight: FontWeight.w500
                  //fontFamily: ScreensFontFamlty.FONT_FAMILTY
                  ),
          filled: true,
          fillColor: Colors.white,
          errorStyle: AppTypoGraphy.errorHintStyle),
      validator: (String email) {
        if (email.isEmpty) {
          return "User Name";
        } else {
          return null;
        }
      },
    );

    final password = TextFormField(
      controller: etPasswordController,
      obscureText: true,
      // cursorColor: Color.fromRGBO(64, 75, 96, .9),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      //controller: firstNameTextController,
      //validator: _validateFirstName,
      maxLength: 128,
      style: TextStyle(
        color: Color.fromRGBO(64, 75, 96, .9),
        //fontFamily: ScreensFontFamlty.FONT_FAMILTY
      ),
      decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(
            Icons.lock,
            size: 22,
            color: Color(0xFF72868a),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: const OutlineInputBorder(
              borderSide: const BorderSide(

                  // color: Color.fromARGB(255, 232, 232, 232),
                  color: Colors.white,
                  width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(
                  // color: Color.fromARGB(255, 232, 232, 232),
                  color: Colors.white,
                  width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(
                  // color: Color.fromARGB(255, 232, 232, 232),
                  color: Colors.white,
                  width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          hintText: "Password",
          hintStyle:
              TextStyle(color: Color(0xFF72868a), fontWeight: FontWeight.w500
                  //fontFamily: ScreensFontFamlty.FONT_FAMILTY
                  ),
          filled: true,
          fillColor: Colors.white,
          errorStyle: AppTypoGraphy.errorHintStyle),
      validator: (String password) {
        if (password.isEmpty) {
          return "password";
        } else {
          return null;
        }
      },
    );

    // final password = TextFormField(
    //   autofocus: false,
    //   obscureText: true,
    //   decoration: InputDecoration(
    //     hintText: 'Password',
    //     hintStyle: TextStyle(color: Colors.white54),
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    //   ),
    // );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
      child: RaisedButton(
        colorBrightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // netWorkChek();
            LoginPrefrences loginPrefrences = LoginPrefrences();

            NetworkConnectivity.check().then((internet) async {
              if (internet) {
                bool userUth = await fetchUserAuth(
                    etUserNameController.text, etPasswordController.text);

                setState(() {
                  isLoading = true;
                });
                Future.delayed(const Duration(milliseconds: 1500), () {
                  if (userUth) {
                    loginPrefrences.setUser(apiResponce.data.userId);

                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(pageBuilder: (BuildContext context,
                            Animation animation, Animation secondaryAnimation) {
                          return Dashboard();
                        }, transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return new SlideTransition(
                            position: new Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        }),
                        (Route route) => false);
                  } else {
                    showMessageError("Wrong user name or password");
                    setState(() {
                      isLoading = false;
                    });
                  }
                });
              } else {
                //show network erro
                showMessageError("Network is not avalable");
              }
            });
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Log In', style: TextStyle(color: Colors.blue[400])),
      ),
    );

    final progressIndicator = Padding(
        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: 20,
                width: 20,
                margin: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ),
          ],
        ));

    // final backtext = FlatButton(
    //   child: Text(
    //     'click in login to goto first screen!',
    //     style: TextStyle(color: Colors.black54),
    //   ),
    //   onPressed: () {},
    // );

    return Container(
      height: MediaQuery.of(context).size.height + 100,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
            begin: Alignment(1.0, 0.0),
            end: Alignment(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Logo and company namw widget
                logoAndName(),
                Card(
                  color: AppTheme.appBackgroundColorforloginCard,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 3,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 10),
                    children: <Widget>[
                      SizedBox(height: 15.0),

                      //email widget
                      email,
                      SizedBox(height: 8.0),

                      // password widget
                      password,
                      Container(
                          child: isLoading ? progressIndicator : loginButton),
                    ],
                  ),
                ),

                // developerDetila()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget developerDetila() {
    return Container(
      margin: EdgeInsets.only(top: 70),
      child: SizedBox(
        height: 50,
        width: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Developed by.",
                style: AppTypographyStyles.titleTextStyle,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Vision Plus Solution Provider",
                style: AppTypographyStyles.headingTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
