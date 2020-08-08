import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sale_order_app/CommonWidegets/commonWidgets..dart';
import 'package:sale_order_app/Models/deliveryChallan.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/Services/deliveryChallanService.dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:sale_order_app/config/methods.dart';
import 'package:sale_order_app/config/darkThemePrefrences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:get_it/get_it.dart';
import 'package:sale_order_app/ui/Screens/DeliveryChallanScreen/deliveryChallanDetailScreenListCard.dart';

class DCListScreen extends StatefulWidget {
  @override
  _DCListScreenState createState() => _DCListScreenState();
}

class _DCListScreenState extends State<DCListScreen> {
//Getting the delivery order sesrvice
  DCService get doService => GetIt.I<DCService>();

  //Api responce call for delivery order
  APIResponce<List<DeliveryChallan>> apiResponce;
  //Api responce for delivery order status update

  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  //Api responce for delivery order status update
  APIResponce<String> updateDeliveryChallanStatusApiResponce;
  bool updateDeliveryOrderStatusIsLoading = false;

  @override
  void initState() {
   

    //callinf main data functon for this screen
    netWorkChek();
    //_fetchSammury();

    super.initState();
  }

  netWorkChek() async {
    await NetworkConnectivity.check().then((internet) async {
      // clear past user

      if (internet) {
        _getDoListData();
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
      duration: const Duration(seconds: 2),
    ));
  }

  void showMessageError(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      duration: const Duration(seconds: 2),
    ));
  }

// fetching the Dashboard data
  _getDoListData() async {
    setState(() {
      isLoading = true;
    });

    apiResponce = await doService.getDCList();

    if (apiResponce == null) {
      setState(() {
        isLoading = false;
      });
      showMessageError("Something went wrong !!!");
      // print(" ${apiResponce.errorMessage}");
    } else if (apiResponce.error) {
      setState(() {
        isLoading = false;
      });
      showMessageError("Something went wrong !!!");
    }
// print("${apiResponce.data.apr}");
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //######################################################################
  Future<bool> updateDeliveryChallanStatus(int doId, int status) async {
    setState(() {
      updateDeliveryOrderStatusIsLoading = true;
    });

 LoginPrefrences loginPrefrences = new LoginPrefrences();
    int userId = await loginPrefrences.getUser();
    updateDeliveryChallanStatusApiResponce =
        await doService.updateDeliveryChallanStatus(doId, status,userId);

    if (updateDeliveryChallanStatusApiResponce.data == null) {
      showMessageError("Something went wrong");
      setState(() {
        updateDeliveryOrderStatusIsLoading = false;
      });
      return false;
    } else if (updateDeliveryChallanStatusApiResponce.data.contains("OK")) {
      showMessageSuccess("Status updated");
      setState(() {
        updateDeliveryOrderStatusIsLoading = false;
      });
      return true;
    } else if (!updateDeliveryChallanStatusApiResponce.data.contains("OK")) {
      showMessageSuccess("${updateDeliveryChallanStatusApiResponce.data}");
      setState(() {
        updateDeliveryOrderStatusIsLoading = false;
      });
      return false;
    } else {
      showMessageError("Something went wrong");
      setState(() {
        updateDeliveryOrderStatusIsLoading = false;
      });
      return false;
    }
  }

  String getDateAndTime(String rawDateAndTime) {
    var rawDate = DateTime.tryParse(rawDateAndTime);
    var formatter = DateFormat.yMMMMd('en_US');
    String formatted = formatter.format(rawDate);
    print("Date  in date formate: $formatted");

    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: BackButton(color: Colors.black),
            title:
                Text("Delivery challan", style: TextStyle(color: Colors.black87)),
            backgroundColor: Colors.white,
          ),
          // backgroundColor: Theme.of(context).colorScheme.primary,

          // backgroundColor: AppColors.loginGradientStart,
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              return netWorkChek();
            },
            child: Builder(
              builder: (BuildContext context) {
                if (isLoading) {
                  return CommonWidgets.progressIndicator;
                }

                if (apiResponce == null || apiResponce.data.length == 0) {
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

                return _bodyWidget();
              },
            ),
          )),
    );
  }

  Widget _bodyWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
            key: UniqueKey(),
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            // controller: lazyListscrollController,
            //  itemCount: globalItemsList.data.length,

            itemCount: apiResponce.data.length,
            itemBuilder: (BuildContext context, int index) {
              // Items thisListItems = globalItemsList
              //  .data[index];
              // (snapshot.data[snapshot.data.length - index].title);
              //  if (index == globalItemsList.data.length - 1) {
              // print("length matched");
              // return Padding(
              //   padding: const EdgeInsets.only(bottom: 18.0),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     mainAxisSize: MainAxisSize.min,
              //     children: <Widget>[
              //       SizedBox(
              //         width: 18,
              //         height: 18,
              //         child: CircularProgressIndicator(
              //           strokeWidth: 2.5,
              //         ),
              //       ),

              //     ],
              //   ),
              // );
              //  }
              //  else{

              return dOListCardState(apiResponce.data[index]);

              // return DOListCard(
              //   deliveryOrder: apiResponce.data[index],
              // );
            }
            //   },

            ),
      ),
    );
  }

  Widget dOListCardState(DeliveryChallan deliveryChallan) {
    return Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),

        // height: 75,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),

          // color: Colors.white,

          margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          child: Container(
            // decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: ListTile(
                contentPadding: EdgeInsets.only(
                  left: 10.0,
                  right: 15.0,
                ),
                // leading: Container(
                //   padding: EdgeInsets.only(right: 0.0),
                //   // decoration: new BoxDecoration(
                //   //     border: new Border(
                //   //         right: new BorderSide(width: 1.0, color: Colors.black26))),
                //   child: Container(

                //   ),
                // ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 0),
                  child: Column(
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     "Vision plus",
                      //     style: TextStyle(
                      //         color: Colors.black87,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18),
                      //   ),
                      // ),
                      Card(
                        color: AppTheme.appBackgroundColorforCard1,
                        elevation: 0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0, bottom: 5, left: 8, right: 8),
                              child: deliveryChallan.customerName == null
                                  ? Text(
                                      "N/A",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  : Text(
                                      "${deliveryChallan.customerName}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                            ),
                            // Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     children: <Widget>[
                            //       Text("Customer Name",
                            //           style: TextStyle(
                            //               color: Colors.white70,
                            //               fontWeight: FontWeight.w500,
                            //               fontSize: 14)),
                            //       SizedBox(
                            //         width: 5,
                            //       ),
                            //       Container(
                            //           height: 25,
                            //           decoration: BoxDecoration(
                            //               borderRadius: BorderRadius.only(
                            //                   topLeft: Radius.circular(5.0),
                            //                   bottomRight: Radius.circular(5.0),
                            //                   bottomLeft: Radius.circular(5),
                            //                   topRight: Radius.circular(5))),
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(right: 5),
                            //             child: Center(
                            //                 child: Text("Ali Ahmad",
                            //                     style: TextStyle(
                            //                         color: Colors.white70,
                            //                         fontWeight: FontWeight.w700,
                            //                         fontSize: 14))),
                            //           )),
                            //     ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text("DC# :",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5.0),
                                              bottomRight: Radius.circular(5.0),
                                              bottomLeft: Radius.circular(5),
                                              topRight: Radius.circular(5))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 0),
                                        child: Center(
                                            child: deliveryChallan.dcNo == null
                                                ? Text("N/A",
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12))
                                                : Text("${deliveryChallan.dcNo}",
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12))),
                                      )),
                                ]),
                                Row(children: <Widget>[
                                  // ),
                                  Container(
                                      height: 25,
                                      // width: MediaQuery.of(context).size.width -
                                      //     MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                          // border:
                                          //     Border.all(width: 1, color: Colors.white30),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5.0),
                                              bottomRight: Radius.circular(5.0),
                                              bottomLeft: Radius.circular(5),
                                              topRight: Radius.circular(5))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 0),
                                        child: Center(
                                            child: deliveryChallan.dcDate == null
                                                ? Text("--:--:--",
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12))
                                                : Text(
                                                    "${getDateAndTime(deliveryChallan.dcDate)}",
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12))),
                                      )),
                                ])
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // : Text("N/A",style: AppTypographyStyles.smallTextStyleNotVailable),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //  items.dcNo !=null ?

                    //: Text("N/A",style:AppTypographyStyles.smallTextStyle),
                    //  items.dcDate !=null ? Text(DateTimeConverter.getDateAndTime(items.dcDate), style: AppTypographyStyles.smallTextStyle) :Text("N/A",style:AppTypographyStyles.smallTextStyle),

                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 150,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          // controller: lazyListscrollController,
                            itemCount: deliveryChallan.items.length,
                         // itemCount: deliveryOrder.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Items thisListItems = globalItemsList
                            //  .data[index];
                            // (snapshot.data[snapshot.data.length - index].title);
                            //  if (index == globalItemsList.data.length - 1) {
                            //  print("length matched");
                            // return Padding(
                            //   padding: const EdgeInsets.only(bottom: 18.0),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: <Widget>[
                            //       SizedBox(
                            //         width: 18,
                            //         height: 18,
                            //         child: CircularProgressIndicator(
                            //           strokeWidth: 2.5,
                            //         ),
                            //       ),

                            //     ],
                            //   ),
                            // );
                            //  }
                            //  else{

                            return DeliveryChallanDetailScreenListCard(
                              items: deliveryChallan.items[index],
                            );
                          }
                          //   },

                          ),
                    ),

                    bottomPart(context, deliveryChallan),
                    bottomButtons(context, deliveryChallan)
                  ],
                ),

                // trailing:
                //     Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SaleOrderDetailScreen()));
                }),
          ),
        ));
  }

  Widget bottomPart(BuildContext context, DeliveryChallan deliveryChallan) {
    return Container(
        // decoration: BoxDecoration(
        //   // color: Colors.grey,
        //   border:
        //       Border.all(color: Color.fromRGBO(250, 250, 250, 0.3), width: 1.5),
        //   borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(2.0),
        //       bottomRight: Radius.circular(2.0),
        //       bottomLeft: Radius.circular(2),
        //       topRight: Radius.circular(2)),
        //   gradient: new LinearGradient(
        //       colors: [Color(0xFF2193b0), Color(0xFF2193b0)],
        //       begin: Alignment(1.0, 3.0),
        //       end: Alignment(0.0, 0.0),
        //       // begin: const FractionalOffset(0.0, 1.0),
        //       // end: const FractionalOffset(1.0, 1.0),
        //       stops: [0.0, 2.0],
        //       tileMode: TileMode.clamp),
        // ),
        child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Text(
          //   "Sales",
          //   style: Theme.of(context).textTheme.title,
          // ),
          Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                gradient: new LinearGradient(
                    colors: [
                      Color(0xFF43cea2),
                      AppTheme.appBackgroundColorforCard1
                    ],
                    begin: Alignment(0.0, 1.0),
                    end: Alignment(0.0, 0.0),
                    // begin: const FractionalOffset(0.0, 1.0),
                    // end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 2.0],
                    tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
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
                      Text("Balance",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 11)),

                      SizedBox(height: 5),
                      Flexible(
                        child: new SizedBox(
                          // width: 40,
                          // height: 30,
                          child: deliveryChallan.balance == null
                              ? Text("N/A",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12))
                              : Text(
                                  "${Constents.numbaerFormate.format(deliveryChallan.balance)}",
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                gradient: new LinearGradient(
                    colors: [
                      Color(0xFF43cea2),
                      AppTheme.appBackgroundColorforCard1
                    ],
                    begin: Alignment(0.0, 1.0),
                    end: Alignment(0.0, 0.0),
                    // begin: const FractionalOffset(0.0, 1.0),
                    // end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 2.0],
                    tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
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
                      Text("Limit",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 11)),

                      SizedBox(height: 5),
                      Flexible(
                        child: new SizedBox(
                          // width: 40,
                          // height: 30,
                          child: deliveryChallan.limit == null
                              ? Text("N/A",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12))
                              : Text(
                                  "${Constents.numbaerFormate.format(deliveryChallan.limit)}",
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                        ),
                      ),
                    ]),
              ),
            ),
          ),

          Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                gradient: new LinearGradient(
                    colors: [
                      Color(0xFF43cea2),
                      AppTheme.appBackgroundColorforCard1
                    ],
                    begin: Alignment(0.0, 1.0),
                    end: Alignment(0.0, 0.0),
                    // begin: const FractionalOffset(0.0, 1.0),
                    // end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 2.0],
                    tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
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
                      Text("This DO",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 11)),

                      SizedBox(height: 5),
                      Flexible(
                        child: new SizedBox(
                          // width: 40,
                          // height: 30,
                          child: deliveryChallan.thisDC == null
                              ? Text("N/A",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12))
                              : Text(
                                  "${Constents.numbaerFormate.format(deliveryChallan.thisDC)}",
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                gradient: deliveryChallan.balanceAfterDC >= 0 ? LinearGradient(
                    colors: [
                      Color(0xFF43cea2),
                      AppTheme.appBackgroundColorforCard1
                    ],
                    begin: Alignment(0.0, 1.0),
                    end: Alignment(0.0, 0.0),
                    // begin: const FractionalOffset(0.0, 1.0),
                    // end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 2.0],
                    tileMode: TileMode.clamp) :  LinearGradient(
                    colors: [
                      Colors.red[300],
                      Colors.red[300],
                    ],
                    begin: Alignment(0.0, 1.0),
                    end: Alignment(0.0, 0.0),
                    // begin: const FractionalOffset(0.0, 1.0),
                    // end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 2.0],
                    tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
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
                      Text("Balance",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 11)),

                      SizedBox(height: 5),
                      Flexible(
                        child: new SizedBox(
                          // width: 40,
                          // height: 30,
                          child: deliveryChallan.balanceAfterDC == null
                              ? Text("N/A",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12))
                              : Text(
                                  "${Constents.numbaerFormate.format(deliveryChallan.balanceAfterDC)}",
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget bottomButtons(BuildContext context, DeliveryChallan deliveryChallan) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 5, left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Text("           ",style: Theme.of(context).textTheme.title,),
            //Container()
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 0),
              child: RaisedButton(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () async {
                  await NetworkConnectivity.check().then((internet) async {
                    if (internet) {
                      bool status =
                          await updateDeliveryChallanStatus(deliveryChallan.dcId, 1);
                      print(
                          "value updated of delivery order status :::  $status  and do id ${deliveryChallan.dcId}");
                      if (status) {
                        print(
                            "value updated of delivery order status :::  $status  and do id ${deliveryChallan.dcId}");

                        setState(() {
                          int indexD = apiResponce.data.indexOf(deliveryChallan);
                          apiResponce.data.removeAt(indexD);
                          apiResponce.data.length;
                          print("List update call ${apiResponce.data.length}");
                        });
                      }
                    } else {
                      //show network erro
                      showMessageError("Network is not avalable !!!");
                    }
                  });
                },
                color: AppTheme.appBackgroundColorforCard1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
                  child: Text('Approve',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
              child: RaisedButton(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () async {
                  // await NetworkConnectivity.check().then((internet) async {
                  //   if (internet) {
                  //     bool status =
                  //         await updateDeliveryOrderStatus(deliveryOrder.id, 0);
                  //     print(
                  //         "value updated of delivery order status :::  $status  and do id ${deliveryOrder.id}");
                  //     if (status) {
                  //       print(
                  //           "value updated of delivery order status :::  $status  and do id ${deliveryOrder.id}");

                  //       setState(() {
                  //         int indexD = apiResponce.data.indexOf(deliveryOrder);
                  //         apiResponce.data.removeAt(indexD);
                  //         apiResponce.data.length;
                  //         print(
                  //             "List update call unaaprove ${apiResponce.data.length}");
                  //       });
                  //     }
                  //   } else {
                  //     //show network erro
                  //     showMessageError("Network is not avalable !!!");
                  //   }
                  // });
                  _onAlertButtonsPressed(deliveryChallan, context);
                },
                color: Colors.red[300],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                  child: Text('Reject',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onAlertButtonsPressed(DeliveryChallan deliveryChallan, BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Do you really want to reject this Delivery Order ?",
      desc: "${deliveryChallan.customerName}",
      buttons: [
        DialogButton(
          child: Text(
            "YES  Reject",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () async {
            Navigator.pop(context);
            await NetworkConnectivity.check().then((internet) async {
              if (internet) {
                bool status =
                    await updateDeliveryChallanStatus(deliveryChallan.dcId, 0);
                print(
                    "value updated of delivery order status :::  $status  and do id ${deliveryChallan.dcId}");
                if (status) {
                  print(
                      "value updated of delivery order status :::  $status  and do id ${deliveryChallan.dcId}");

                  setState(() {
                    int indexD = apiResponce.data.indexOf(deliveryChallan);
                    apiResponce.data.removeAt(indexD);
                    apiResponce.data.length;
                    print(
                        "List update call unaaprove ${apiResponce.data.length}");
                  });
                  
                }
              } else {
                //show network erro
                showMessageError("Network is not avalable !!!");
              }
            });
          },
          color: Colors.red[300],
        ),
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}
