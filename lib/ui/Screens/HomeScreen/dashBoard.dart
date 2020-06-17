import 'package:flutter/material.dart';
import 'package:sale_order_app/CommonWidegets/commonWidgets..dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/config/darkThemePrefrences.dart';
import 'package:sale_order_app/ui/Screens/DeliveryOrderScreen/deliveryOrderListScreen.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:sale_order_app/ui/Screens/LoginScreen/loginScreen.dart';
import 'package:sale_order_app/ui/Screens/SaleOrderScreen/saleOrderListScreen.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:sale_order_app/Services/summaryService.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:get_it/get_it.dart';
import 'package:sale_order_app/Models/sammury.dart';
import 'package:sale_order_app/config/methods.dart';
import 'package:connectivity/connectivity.dart';

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

class addCahrts {
  final String label;
  final int value;
  addCahrts(this.label, this.value);
}

class _DashboardBodyState extends State<DashboardBody> {
  //Getting user service to get Summary
  SummaryService get summaryService => GetIt.I<SummaryService>();

  //Api responce call for Summary
  APIResponce<Summary> apiResponce;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final TextStyle whiteText = TextStyle(color: Colors.white);

  String actualDropdown = DashboardBody.chartDropdownItems[0];

  int actualChart = 0;
  static var chartDisplay, piChartDisplay;
  var data;

  @override
  void initState() {
    // TODO: implement initState

    //callinf main data functon for this screen
    netWorkChek();
    //_fetchSammury();

    super.initState();
  }

  netWorkChek() async {
    await NetworkConnectivity.check().then((internet) async {
      // clear past user

      if (internet) {
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

// fetching the Dashboard data
  _fetchSammury() async {
    setState(() {
      isLoading = true;
    });

    apiResponce = await summaryService.getSammury();

    setState(() {
      var data = [
        addCahrts(
            "Jan", apiResponce.data.jan != null ? apiResponce.data.jan : 10),
        addCahrts(
            "Feb", apiResponce.data.feb != null ? apiResponce.data.feb : 10),
        addCahrts(
            "Mar", apiResponce.data.mar != null ? apiResponce.data.mar : 10),
        addCahrts(
            "Apr", apiResponce.data.apr != null ? apiResponce.data.apr : 10),
        addCahrts(
            "May", apiResponce.data.may != null ? apiResponce.data.may : 10),
        addCahrts(
            "Jun", apiResponce.data.jun != null ? apiResponce.data.jun : 10),
        addCahrts(
            "Jul", apiResponce.data.jul != null ? apiResponce.data.jul : 10),
        addCahrts(
            "Aug", apiResponce.data.aug != null ? apiResponce.data.aug : 10),
        addCahrts(
            "Sep", apiResponce.data.sep != null ? apiResponce.data.sep : 10),
        addCahrts(
            "Oct", apiResponce.data.oct != null ? apiResponce.data.oct : 10),
        addCahrts(
            "Nov", apiResponce.data.nov != null ? apiResponce.data.nov : 10),
        addCahrts(
            "Dec", apiResponce.data.dec != null ? apiResponce.data.dec : 10),
      ];
      // data =  charts[actualChart];

      var series = [
        chart.Series(
            domainFn: (addCahrts addcharts, _) => addcharts.label,
            measureFn: (addCahrts addcharts, _) => addcharts.value,
            id: "AddCahrts",
            data: data
            // data:  charts[actualChart],

            )
      ];

      chartDisplay = chart.BarChart(
        series,
        animationDuration: Duration(microseconds: 2000),
      );
    });

    // print("responceApi error in dashBoard ${apiResponce.errorMessage}");

    if (apiResponce.data == null) {
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
        key: _scaffoldKey,
        //backgroundColor: Theme.of(context).colorScheme.primary,
        // backgroundColor:Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Vision Plus",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 27,
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

          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   mainAxisSize: MainAxisSize.max,
          //   children: <Widget>[
          //     Text("Vision Plus", style: Theme.of(context).textTheme.display1),
          //     // GestureDetector(
          //     //   child: Icon(
          //     //     Icons.settings,
          //     //   ),
          //     //   onTap: () {
          //     //     Navigator.push(
          //     //       context,
          //     //       MaterialPageRoute(builder: (context) => Settings()),
          //     //     );
          //     //   },
          //     // ),
          //   ],
          // ),

          centerTitle: true,
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            return netWorkChek();
          },
          child: Builder(
            builder: (_) {
              if (isLoading) {
                return CommonWidgets.progressIndicator;
              }

              if (apiResponce == null) {
                // print("responceApi error in dashBoard ${apiResponce.errorMessage}");
                return _buildBody(context);
              }

              return _buildBody(context);
            },
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      // decoration: BoxDecoration(
      //     color: Color.fromRGBO(250, 250, 250, 0.93),
      //     borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(2.0),
      //         bottomRight: Radius.circular(2.0),
      //         bottomLeft: Radius.circular(35),
      //         topRight: Radius.circular(35))
      //         ),

      // color: Theme.of(context).colorScheme.primary,
      // height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 15.0, left: 15, bottom: 6, top: 20),
        child: Column(
          children: <Widget>[
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 8.0),
            //     child: _buildHeader(),
            //   ),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Text(
                //   "Sales",
                //   style: Theme.of(context).textTheme.title,
                // ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 16,
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // Padding(
                            //   padding: const EdgeInsets.all(3.0),
                            //   child: Icon(
                            //     Icons.find_replace,
                            //     size: 13,
                            //     color: Colors.white,
                            //   ),

                            //),
                            Text("Sales",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20)),

                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 35.0, bottom: 3),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.find_replace,
                                      size: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text("MTD",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                            new Flexible(
                              child: new SizedBox(
                                  width: 120,
                                  // height: 30,
                                  child: apiResponce == null
                                      ? Text("N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))
                                      : Text(
                                          "${Constents.numbaerFormate.format(apiResponce.data.mTD) + " M"}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                            ),
                          ]),
                    ),
                  ),
                ),

                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      gradient: new LinearGradient(
                          colors: [Color(0xFF43cea2), Color(0xFF0b8793)],
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Sales",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 35.0, bottom: 3),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.find_replace,
                                      size: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text("YTD",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                            new Flexible(
                              child: new SizedBox(
                                  width: 120,
                                  // height: 30,
                                  child: apiResponce == null
                                      ? Text("N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))
                                      : Text(
                                          "${Constents.numbaerFormate.format(apiResponce.data.yTD) + " M"}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Text(
                //   "Sales",
                //   style: Theme.of(context).textTheme.title,
                // ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      gradient: new LinearGradient(
                          colors: [Color(0xFF00bf8f), Color(0xFF267899)],
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Sales",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 35.0, bottom: 3),
                              child: Row(
                                children: <Widget>[
                                  //             Padding(
                                  //   padding: const EdgeInsets.all(3.0),
                                  //   child: Icon(
                                  //     Icons.find_replace,
                                  //     size: 13,
                                  //     color: Colors.white,
                                  //   ),

                                  // ),
                                  Text("Receivable",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                            new Flexible(
                              child: new SizedBox(
                                  width: 120,
                                  // height: 30,
                                  child: apiResponce != null
                                      ? Text(
                                          "${Constents.numbaerFormate.format(apiResponce.data.receivable) + " M"}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))
                                      : Text("N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                            ),
                          ]),
                    ),
                  ),
                ),

                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      gradient: new LinearGradient(
                          colors: [Color(0xFF0b8793), Color(0xFF3cd3ad)],
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Sales",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 35.0, bottom: 3),
                              child: Text("Pending SO",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                            ),
                            new Flexible(
                              child: new SizedBox(
                                  width: 120,
                                  // height: 30,
                                  child: apiResponce != null
                                      ? Text(
                                          "${Constents.numbaerFormate.format(apiResponce.data.pendingSO) + " M"}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))
                                      : Text("N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),

            Container(
              // decoration: BoxDecoration(
              //   color: Colors.grey,
              //   border: Border.all(
              //       color: Color.fromRGBO(250, 250, 250, 0.3), width: 1.5),
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(2.0),
              //     bottomRight: Radius.circular(2.0),
              //     bottomLeft: Radius.circular(2),
              //     topRight: Radius.circular(15),
              //   ),
              //   gradient: new LinearGradient(
              //       colors: [Color(0xFF2193b0), Color(0xFF2193b0)],
              //       begin: Alignment(1.0, 0.0),
              //       end: Alignment(0.0, 0.0),
              //       // begin: const FractionalOffset(0.0, 1.0),
              //       // end: const FractionalOffset(1.0, 1.0),
              //       stops: [0.0, 2.0],
              //       tileMode: TileMode.clamp),
              // ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 20, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Text("           ",style: Theme.of(context).textTheme.title,),
                    //Container()

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
                      // SizedBox(
                      //   width: 5,
                      // ),
                      // Container(
                      //     height: 25,
                      //     // width: MediaQuery.of(context).size.width -
                      //     //     MediaQuery.of(context).size.width * 0.5,
                      //     decoration: BoxDecoration(
                      //         // border:
                      //         //     Border.all(width: 1, color: Colors.white30),
                      //         borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(5.0),
                      //             bottomRight: Radius.circular(5.0),
                      //             bottomLeft: Radius.circular(5),
                      //             topRight: Radius.circular(5))),
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 0, horizontal: 0),
                      //       child: Center(
                      //           child: Text("765495 M",
                      //               style: TextStyle(
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.w800,
                      //                   fontSize: 15))),
                      //     )),

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
                            child: Text("Delivery Order",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14)),
                          ),
                        ),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        // Container(
                        //     height: 25,
                        //     // width: MediaQuery.of(context).size.width -
                        //     //     MediaQuery.of(context).size.width * 0.5,
                        //     decoration: BoxDecoration(
                        //         // border:
                        //         //     Border.all(width: 1, color: Colors.white30),
                        //         borderRadius: BorderRadius.only(
                        //             topLeft: Radius.circular(5.0),
                        //             bottomRight: Radius.circular(5.0),
                        //             bottomLeft: Radius.circular(5),
                        //             topRight: Radius.circular(5))),
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 0, horizontal: 0),
                        //       child: Center(
                        //           child: Text("765765 M",
                        //               style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.w800,
                        //                   fontSize: 15))),
                        //     )),

                        onPressed: () {
                          NetworkConnectivity.check().then((internet) async {
                            // clear past user

                            if (internet) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DOListScreen()));
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
              child: Text("Net Sales",
                  style: TextStyle(
                      color: Color(0xFF2193b0),
                      fontWeight: FontWeight.w700,
                      fontSize: 20)),
            ),

            //    Container(
            //         color: Theme.of(context).colorScheme.primary,
            //         child: Padding(
            //             padding: const EdgeInsets.all(24.0),
            //             //child: chartDisplay,
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>[
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: <Widget>[
            //                     Column(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: <Widget>[
            //                       //   Text('Total sale Graph',
            //                       //       style: TextStyle(color: Colors.green)),
            //                       //   Padding(
            //                       //     padding: const EdgeInsets.only(top: 8.0),
            //                       //     child: Text('15675',
            //                       //         style:
            //                       //             Theme.of(context).textTheme.headline),
            //                       //   ),
            //                        ],
            //                     ),
            //                     DropdownButton(
            //                         isDense: true,
            //                         value: actualDropdown,
            //                         onChanged: (String value) => setState(() {
            //                               actualDropdown = value;
            //                               actualChart = DashboardBody
            //                                   .chartDropdownItems
            //                                   .indexOf(value);

            //                                   var series =[chart.Series(
            //   domainFn: (addCahrts addcharts,_) =>addcharts.label,
            //   measureFn: (addCahrts addcharts,_) =>addcharts.value,
            //   id: "AddCahrts",
            //   data:  charts[actualChart],

            // )];

            // chartDisplay = chart.BarChart(series ,animationDuration: Duration(microseconds: 2000),);

            //                                   // data =  charts[actualChart];// Refresh the chart
            //                             }),
            //                         items: DashboardBody.chartDropdownItems
            //                             .map((String title) {
            //                           return DropdownMenuItem(
            //                             value: title,
            //                             child: Text(title,
            //                                 style: TextStyle(
            //                                     color: Colors.blue,
            //                                     fontWeight: FontWeight.w400,
            //                                     fontSize: 14.0)),
            //                           );
            //                         }).toList())
            //                   ],
            //                 ),
            // Padding(padding: EdgeInsets.only(bottom: 4.0)),
            Container(height: 200, child: chartDisplay)
            //                 // Sparkline(
            //                 //   data: charts[actualChart],
            //                 //   lineWidth: 5.0,
            //                 //   lineColor: Colors.greenAccent,
            //                 // )
            //                ],
            //              )
            //              ),
            // ),
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
        loginPrefrences.setUser(false);

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
