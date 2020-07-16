import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sale_order_app/CommonWidegets/commonWidgets..dart';
import 'package:sale_order_app/Models/saleOrder.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/Services/saleOrderService.dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:sale_order_app/config/methods.dart';
import 'package:sale_order_app/ui/Screens/SaleOrderScreen/saleOrderDetailScreenListCard.dart';

class SaleOrderListScreen extends StatefulWidget {
  @override
  _SaleOrderListScreenState createState() => _SaleOrderListScreenState();
}

class _SaleOrderListScreenState extends State<SaleOrderListScreen> {
//Getting user service to get Summary
  SOService get soService => GetIt.I<SOService>();

  //Api responce call for Summary
  APIResponce<List<SaleOrder>> apiResponce;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  //Api responce for delivery order status update
  APIResponce<bool> updateSaleOrderStatusApiResponce;
  bool updateSaleOrderStatusIsLoading = false;

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
        _getSoListData();
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
  _getSoListData() async {
    setState(() {
      isLoading = true;
    });

    apiResponce = await soService.getSoList();

    if (apiResponce == null) {
      setState(() {
        isLoading = false;
      });
      showMessageError("Something went wrong !!!");
      
    } else if (apiResponce.error) {
      setState(() {
        isLoading = false;
      });
       print(" ${apiResponce.errorMessage}");
     // showMessageError("Something went wrong !!!");
    }
// print("${apiResponce.data.apr}");
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //######################################################################
  Future<bool> updateSaleOrderStatus(int doId, int status) async {
    setState(() {
      updateSaleOrderStatusIsLoading = true;
    });

    updateSaleOrderStatusApiResponce =
        await soService.updateSaleOrderStatus(doId, status);

    if (updateSaleOrderStatusApiResponce.data == null) {
      showMessageError("Something went wrong");
      setState(() {
        updateSaleOrderStatusIsLoading = false;
      });
      return false;
    } else if (updateSaleOrderStatusApiResponce.data) {
      showMessageSuccess("Status updated");
      setState(() {
        updateSaleOrderStatusIsLoading = false;
      });
      return true;
    } else {
      showMessageError("Something went wrong");
      setState(() {
        updateSaleOrderStatusIsLoading = false;
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
          // backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: AppBar(
            leading: BackButton(color: Colors.black),
            title: Text("Sale order", style: TextStyle(color: Colors.black87)),
            backgroundColor: Colors.white,
          ),
          // backgroundColor: AppColors.loginGradientStart,
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              return netWorkChek();
            },
            child: Builder(
              builder: (BuildContext context) {
                try {
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
                } catch (ex) {
                  print(ex);
                  return _buildBody(context);
                }
              },
            ),
          )),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: ListView.builder(
          // controller: lazyListscrollController,
          //  itemCount: globalItemsList.data.length,
          itemCount: apiResponce.data.length,
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
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

            //         return SOListCard(
            //   saleOrder: apiResponce.data[index],

            //  );

            return soListCard(
              apiResponce.data[index],
            );
          }
          //   },

          ),
    );
  }

  Widget soListCard(SaleOrder saleOrder) {
    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          margin: new EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
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
                              padding:
                                  const EdgeInsets.only(top: 12.0, bottom: 5),
                              child: saleOrder.name == null
                                  ? Text(
                                      "N/A",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  : Text(
                                      "${saleOrder.name}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
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
                            //                 child: Text("Bilal Ahmad",
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
                                  Text("SO# :",
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
                                            child: saleOrder.sO == null
                                                ? Text("N/A",
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12))
                                                : Text(
                                                    "${saleOrder.sO.toString()}",
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
                                            child: saleOrder.date == null
                                                ? Text("--:--:--",
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12))
                                                : Text(
                                                    "${getDateAndTime(saleOrder.date)}",
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
                          //  itemCount: globalItemsList.data.length,
                          itemCount: saleOrder.items.length,
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

                            return SaleOrderDetailScreenListCard(
                              items: saleOrder.items[index],
                            );
                          }
                          //   },

                          ),
                    ),

                    bottomPart(context, saleOrder),
                    bottomButtons(saleOrder)
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

  Widget bottomPart(BuildContext context, SaleOrder saleOrder) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
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
                          child: saleOrder.balance == null
                              ? Text("N/A",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12))
                              : Text(
                                  "${Constents.numbaerFormate.format(saleOrder.balance)}",
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
                          child: saleOrder.limit == null
                              ? Text("N/A",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12))
                              : Text(
                                  "${Constents.numbaerFormate.format(saleOrder.limit)}",
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
                      Text("This SO",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 11)),
                      SizedBox(height: 5),
                      Flexible(
                        child: new SizedBox(
                          // width: 40,
                          // height: 30,
                          child: saleOrder.thisSO == null
                              ? Text("N/A",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12))
                              : Text(
                                  "${Constents.numbaerFormate.format(saleOrder.thisSO)}",
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
                gradient: saleOrder.balance_ >= 0
                    ? LinearGradient(
                        colors: [
                          Color(0xFF43cea2),
                          AppTheme.appBackgroundColorforCard1
                        ],
                        begin: Alignment(0.0, 1.0),
                        end: Alignment(0.0, 0.0),
                        // begin: const FractionalOffset(0.0, 1.0),
                        // end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 2.0],
                        tileMode: TileMode.clamp)
                    : LinearGradient(
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
                          child: saleOrder.balance_ == null
                              ? Text("N/A",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12))
                              : Text(
                                  "${Constents.numbaerFormate.format(saleOrder.balance_)}",
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

  Widget bottomButtons(SaleOrder saleOrder) {
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
                          await updateSaleOrderStatus(saleOrder.saleOrderId, 1);
                      print(
                          "value updated of delivery sale status :::  $status  and do id ${saleOrder.saleOrderId}");
                      if (status) {
                        print(
                            "value updated of delivery sale status :::  $status  and do id ${saleOrder.saleOrderId}");

                        setState(() {
                          int indexD = apiResponce.data.indexOf(saleOrder);
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
                      style: TextStyle(color: Colors.white, fontSize: 10)),
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
                  _onAlertButtonsPressed(saleOrder, context);
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

  _onAlertButtonsPressed(SaleOrder saleOrder, BuildContext context) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Do you really want to reject this Sale Order ?",
      desc: "${saleOrder.name}",
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
                    await updateSaleOrderStatus(saleOrder.saleOrderId, 0);
                print(
                    "value updated of delivery sale status :::  $status  and do id ${saleOrder.saleOrderId}");
                if (status) {
                  print(
                      "value updated of sale sale status :::  $status  and do id ${saleOrder.saleOrderId}");

                  setState(() {
                    int indexD = apiResponce.data.indexOf(saleOrder);
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
