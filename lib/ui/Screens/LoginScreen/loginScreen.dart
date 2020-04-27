import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/config/darkThemePrefrences.dart';
import 'package:sale_order_app/ui/Screens/HomeScreen/dashBoard.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final snackBar = SnackBar(content: Text('Data processing '));
  @override
  Widget build(BuildContext context) {
    final logo = Column(children: <Widget>[
      Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30.0,
          child: Image.asset('images/logo.png'),
          // child: Icon(
          //   Icons.person_pin,
          //   color: Colors.white70,
          //   size: 90.0,
          // ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text("Vision Plus",
            style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w300)),
      )
    ]);

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



              LoginPrefrences loginPrefrences = LoginPrefrences();
              loginPrefrences.setUser(true);

            //   // If the form is valid, display a Snackbar.
            //  Scaffold.of(context).showSnackBar(snackBar);
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
          }
        },
        padding: EdgeInsets.all(12),
        color: AppTheme.appBackgroundColor,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    // final backtext = FlatButton(
    //   child: Text(
    //     'click in login to goto first screen!',
    //     style: TextStyle(color: Colors.black54),
    //   ),
    //   onPressed: () {},
    // );

    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF3a7bd5)],
            begin: Alignment(1.0, 0.0),
            end: Alignment(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
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
                logo,
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 10),
                    children: <Widget>[
                      // X1Demo(),
                      // Text('happy birthday login),
                      //logo,
                      SizedBox(height: 15.0),
                      email,
                      SizedBox(height: 8.0),
                      password,
                      //SizedBox(height: 14.0),
                      loginButton,
                      //backtext
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
