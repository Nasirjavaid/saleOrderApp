import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sale_order_app/CommonWidegets/commonWidgets..dart';
import 'package:sale_order_app/Models/ytdSale.dart';
import 'package:sale_order_app/Services/ytdSaleService.dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/config/darkThemePrefrences.dart';
import 'package:sale_order_app/ui/Screens/DeliveryChallanScreen/deliveryChallanListScreen.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:sale_order_app/ui/Screens/LoginScreen/loginScreen.dart';
import 'package:sale_order_app/ui/Screens/SaleOrderScreen/saleOrderListScreen.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:sale_order_app/Services/summaryService.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:get_it/get_it.dart';
import 'package:sale_order_app/Models/sammury.dart';
import 'package:sale_order_app/config/methods.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //   return Consumer<AppState>(
    //     builder: (context, appState, _) {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         theme: AppTheme.lightTheme,
    //         darkTheme: AppTheme.darkTheme,
    //         themeMode: appState.darkTheme ? ThemeMode.dark : ThemeMode.light,
    //         home: Container(child: DashboardBody()),
    //       );
    //     },
    //   );
    // }

    return Container(child: DashboardBody());
  }
}

class DashboardBody extends StatefulWidget {
  static final String path = "lib/src/pages/dashboard/dash2.dart";
  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class AddCharts {
  String label;
  int value;
  AddCharts(this.label, this.value);
}

class _DashboardBodyState extends State<DashboardBody> {
  //Getting user service to get Summary
  SummaryService get summaryService => GetIt.I<SummaryService>();
  YTDSaleService get ytdSaleService => GetIt.I<YTDSaleService>();

  //Api responce call for Summary
  APIResponce<Summary> apiResponce;
  APIResponce<List<YTDSale>> apiResponceYTDsale;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final TextStyle whiteText = TextStyle(color: Colors.white);

  String actualDropdown = DashboardBody.chartDropdownItems[0];

  int actualChart = 0;
  static var chartDisplay;
  var data;

  var now = new DateTime.now();
  var current_mon;

 

  @override
  void initState() {
    //calling main data functon for this screen
    
    netWorkChek();

    super.initState();
  }

  netWorkChek() async {
    await NetworkConnectivity.check().then((internet) async {
      // clear past user

      if (internet) {
        _fetchYTDsaleListOfMonths();
        _fetchSammury();
      } else {
        //show network erro
        showMessageError("Network is not avalable !!!");
      }
    });
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

//fetch ytdSale list of months

  _fetchYTDsaleListOfMonths() async {
    apiResponceYTDsale = await ytdSaleService.getYTDSaleList();

    // print("responceApi error in dashBoard ${apiResponce.data.mTD}");

    if (apiResponceYTDsale.data.length == null) {
      // setState(() {
      //   isLoading = false;
      // });
      showMessageError("Something went wrong !!!");
    } else if (apiResponceYTDsale.error) {
      // setState(() {
      //   isLoading = false;
      // });
      showMessageError("Something went wrong !!!");
    }
// print("${apiResponce.data.apr}");
    // setState(() {
    //   isLoading = false;
    // });

//TODO: Graph Work is still  pending //

    var graphData = <AddCharts>[];
    AddCharts adChartsObj;
    for (int i = 0; i < apiResponceYTDsale.data.length; i++) {
      adChartsObj = AddCharts(
          apiResponceYTDsale.data[i].month, apiResponceYTDsale.data[i].amount);

      graphData.add(adChartsObj);
    }
    setState(() {
      var series = [
        chart.Series(
            domainFn: (AddCharts adChartsObj, _) => adChartsObj.label,
            measureFn: (AddCharts adChartsObj, _) => adChartsObj.value,
            id: "AddCahrts",
            data: graphData
            // data:  charts[actualChart],

            )
      ];

      chartDisplay = chart.BarChart(
        series,
        animationDuration: Duration(seconds: 1),
      );
    });
  }

// fetching the Dashboard data
  _fetchSammury() async {
    setState(() {
      isLoading = true;
    });

    apiResponce = await summaryService.getSammury();

    // print("responceApi error in dashBoard ${apiResponce.data.mTD}");

    if (apiResponce.data.mtd == null &&
        apiResponce.data.ytd == null &&
        apiResponce.data.todaySale == null &&
        apiResponce.data.receiveable == null &&
        apiResponce.data.pendingSO == null) {
      setState(() {
        isLoading = false;
      });
      showMessageError("Something went wrong !!!");
    } else if (apiResponce.error) {
      setState(() {
        isLoading = false;
      });
      showMessageError("Something went wrong !!!");
    }
// print("${apiResponce.data.apr}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Akbari Chemical Industries(Pvt) Ltd",
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.w700)),
          actions: <Widget>[
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(Icons.settings_power, color: Colors.black87),
              ),
              onTap: () {
                showAlertDialog(context);
              },
            )
          ],
          centerTitle: true,
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            return netWorkChek();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Builder(
                builder: (_) {
                  if (isLoading) {
                    return CommonWidgets.progressIndicator;
                  }

                  if (apiResponce == null) {
                    // showMessageError("Something went wrong");
                    return InkWell(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Noting here",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Tap to reload",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      )),
                      onTap: () {
                        netWorkChek();
                      },
                    );
                  }

                  return _buildBody(context);
                },
              ),
            ),
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 15.0, left: 15, bottom: 0, top: 20),
        child: Column(
          children: <Widget>[
            Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  gradient: new LinearGradient(
                      colors: [Color(0xFF43cea2), Color(0xFF2193b0)],
                      begin: Alignment(0.0, 1.0),
                      end: Alignment(0.0, 0.0),
                      // begin: const FractionalOffset(0.0, 1.0),
                      // end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 2.0],
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Sales",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20)),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 318,
                                  color: Colors.white38,
                                  height: 1,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.calendar_today,
                                        size: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text("TODAY",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.calendar_view_day,
                                        size: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text("MTD",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.call_to_action,
                                        size: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text("YTD",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Receivable",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18)),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 285,
                                  color: Colors.white38,
                                  height: 1,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.archive,
                                        size: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text("As Per Day",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.work,
                                        size: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text("Pending SO",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                  ],
                                ),
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text("Sales",
                                    style: TextStyle(
                                        color: Colors.transparent,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20)),
                                SizedBox(
                                  height: 22,
                                ),
                                Container(
                                  child: apiResponce.data.todaySale == null
                                      ? Text("N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))
                                      : Text(
                                          "${Constents.numbaerFormate.format(apiResponce.data.todaySale)}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  child: apiResponce.data.mtd == null
                                      ? Text("N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))
                                      : Text(
                                          "${Constents.numbaerFormate.format(apiResponce.data.mtd)}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  child: apiResponce.data.ytd == null
                                      ? Text("N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))
                                      : Text(
                                          "${Constents.numbaerFormate.format(apiResponce.data.ytd)}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18)),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Text("Receivable",
                                    style: TextStyle(
                                        color: Colors.transparent,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18)),
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  child: apiResponce != null
                                      ? Text(
                                          "${Constents.numbaerFormate.format(apiResponce.data.receiveable)}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18))
                                      : Text("N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18)),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  child: apiResponce != null
                                      ? Text(
                                          "${Constents.numbaerFormate.format(apiResponce.data.pendingSO)}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18))
                                      : Text("N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18)),
                                )
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 20, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Text("Sale Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14)),
                        ),
                      ),
                      onPressed: () {
                        NetworkConnectivity.check().then((internet) async {
                          // clear past user

                          if (internet) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SaleOrderListScreen()));
                          } else {
                            //show network erro
                            showMessageError("Network is not avalable !!!");
                          }
                        });
                      },
                    ),
                    RaisedButton(
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("Delivery Challan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14)),
                          ),
                        ),
                        onPressed: () {
                          NetworkConnectivity.check().then((internet) async {
                            // clear past user

                            if (internet) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DCListScreen()));
                            } else {
                              //show network erro
                              showMessageError("Network is not avalable !!!");
                            }
                          });
                        }),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("Net Sales",
                      style: TextStyle(
                          color: Color(0xFF2193b0),
                          fontWeight: FontWeight.w700,
                          fontSize: 20)),
                  SizedBox(
                    width: 4,
                  ),
                  Text("(in 000)",
                      style: TextStyle(
                          color: Color(0xFF2193b0),
                          fontWeight: FontWeight.w700,
                          fontSize: 15)),
                ],
              ),
            ),

            Container(
                width: MediaQuery.of(context).size.width,
                height: 230,
                child: chartDisplay)
            //                 // Sparkline(
            //                 //   data: charts[actualChart],
            //                 //   lineWidth: 5.0,
            //                 //   lineColor: Colors.greenAccent,
            //                 // )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            height: 200,
            width: 200,
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              strokeWidth: 12,
              value: 0.6,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              backgroundColor: Colors.grey.shade700,
            ),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Container(
                child: Material(
              color: Color(0xFFEEEEEE),
              shape: CircleBorder(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // piChartDisplay
                    Text(
                      "${4765756}",
                      style: TextStyle(color: Colors.black45, fontSize: 10),
                    ),
                    Text(
                      "sale",
                      style: TextStyle(color: Colors.black45, fontSize: 14),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.all(2),
                        color: AppTheme.appBackgroundColor,
                        child: Text('Detail',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ))),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.black87),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Logout",
        style: TextStyle(color: Colors.black87),
      ),
      onPressed: () {
        LoginPrefrences loginPrefrences = LoginPrefrences();
        loginPrefrences.setUser(0);

        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(pageBuilder: (BuildContext context,
                Animation animation, Animation secondaryAnimation) {
              return LoginScreen();
            }, transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return new SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 2.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            }),
            (Route route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout !"),
      content: Text("You will be returned to login screen."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
