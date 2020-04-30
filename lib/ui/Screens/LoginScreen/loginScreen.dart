import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:sale_order_app/CommonWidegets/commonWidgets..dart';
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
  @override
  void initState() {
    // TODO: implement initState
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    getLoginScreenLogoAndCompanyName();

    super.initState();
  }

  getLoginScreenLogoAndCompanyName() async {
    setState(() {
      isLoadingForLogoAndName = true;
    });

    apiResponceLoginScreenLogoAndCompanyName =
        await logiService.getLoginScreenLogoAndCompanyName();

    if (apiResponceLoginScreenLogoAndCompanyName.data.companyLogo == null) {
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

  Future<bool> fetchUserAuth() async {
    setState(() {
      isLoading = true;
    });

    apiResponce = await userService.getUserAuth();

    if (apiResponce.error) {
      showMessageError("Something went wrong !");

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      return false;
    }

    if (apiResponce.data.response) {
      // showMessageError("Wrong user name or password !");

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      return true;
    }
    print("${apiResponce.data.authenticatoin}");
    print("${apiResponce.data.response}");

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
        if (isLoadingForLogoAndName) {
          return CommonWidgets.progressIndicator;
        }

        if (apiResponceLoginScreenLogoAndCompanyName == null) {
          return commonlogoAndNameWidget();
        }

        return dynaminlogoAndNameWidget();
      },
    );
  }

  Widget dynaminlogoAndNameWidget() {
    return Column(children: <Widget>[
      Container(
          height: 50,
          child: CachedNetworkImage(
              imageUrl:
                  apiResponceLoginScreenLogoAndCompanyName.data.companyLogo)),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text(
            "${apiResponceLoginScreenLogoAndCompanyName.data.companyName}",
            style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w300)),
      )
    ]);
  }

  Widget commonlogoAndNameWidget() {
    return Column(children: <Widget>[
      Container(
          height: 50,
          child: CachedNetworkImage(
              imageUrl:
                  "https://www.visionplus.com.pk/assets/base/img/layout/logos/logo-02.png")),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text("Vision Plus",
            style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w300)),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // final logo =  Column(children: <Widget>[
    //   Hero(
    //     tag: 'hero',
    //     child: CircleAvatar(
    //       backgroundColor: Colors.transparent,
    //       radius: 30.0,
    //       child:Container(height: 40,
    //       child:CachedNetworkImage(imageUrl: "https://www.visionplus.com.pk/assets/base/img/layout/logos/logo-02.png")),
    //       // child: Icon(
    //       //   Icons.person_pin,
    //       //   color: Colors.white70,
    //       //   size: 90.0,
    //       // ),
    //     ),
    //   ),
    //   Padding(
    //     padding: const EdgeInsets.all(25.0),
    //     child: Text("Vision Plus",
    //         style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 40,
    //             fontWeight: FontWeight.w300)),
    //   )
    // ]);

    final email = TextFormField(
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
          hintText: "Email",
          hintStyle:
              TextStyle(color: Color(0xFF72868a), fontWeight: FontWeight.w500
                  //fontFamily: ScreensFontFamlty.FONT_FAMILTY
                  ),
          filled: true,
          fillColor: Color(0xFFe4f4f7),
          errorStyle: TextStyle(color: Color(0xFF72868a))),
      validator: (String email) {
        if (email.isEmpty) {
          return "Please enter email";
        } else {
          return null;
        }
      },
    );

    final password = TextFormField(
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
          fillColor: Color(0xFFe4f4f7),
          errorStyle: TextStyle(color: Color(0xFF72868a))),
      validator: (String password) {
        if (password.isEmpty) {
          return "Please enter password";
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // netWorkChek();
            LoginPrefrences loginPrefrences = LoginPrefrences();

            NetworkConnectivity.check().then((internet) async {
              if (internet) {
                bool userUth = await fetchUserAuth();

                if (userUth) {
                  loginPrefrences.setUser(true);

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
                  showMessageError(" wring User Name or Password");
                }
              } else {
                //show network erro
                showMessageError("Network is not avalable");
              }
            });
          }
        },
        padding: EdgeInsets.all(12),
        color: AppTheme.appBackgroundColor,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
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
                  valueColor:
                      AlwaysStoppedAnimation(AppTheme.appBackgroundColor),
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

    return
           Container(
            height: MediaQuery.of(context).size.height+100,
        decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [Color(0xFF2193b0), Color(0xFF3a7bd5)],
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5,
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
    return 
    
       Container(
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
