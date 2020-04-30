import 'package:flutter/material.dart';
import 'package:sale_order_app/CommonWidegets/commonWidgets..dart';
import 'package:sale_order_app/Models/deliveryOrder.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/Services/deliveryOrderService.dart';
import 'package:sale_order_app/config/methods.dart';
import 'package:sale_order_app/ui/Screens/DeliveryOrderScreen/deliveryOrderListCard.dart';
import 'package:get_it/get_it.dart';

class DOListScreen extends StatefulWidget {
  @override
  _DOListScreenState createState() => _DOListScreenState();
}

class _DOListScreenState extends State<DOListScreen> {
//Getting user service to get Summary
  DOService get doService => GetIt.I<DOService>();

  //Api responce call for Summary
  APIResponce<List<DeliveryOrder>> apiResponce;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

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
  _getDoListData() async {
    setState(() {
      isLoading = true;
    });

    apiResponce = await doService.getDoList();

    if (apiResponce.error) {
      setState(() {
        isLoading = false;
      });
      showMessageError("Something went wrong !!!");
      print(" ${apiResponce.errorMessage}");
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
    return Container(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: BackButton(color: Colors.black),
            title:
                Text("Delivery order", style: TextStyle(color: Colors.black87)),
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

                if (apiResponce == null) {
                  // showMessageError("Something went wrong");
                  return Center(child: Text("Pull to refresh."));
                }

                return _bodyWidget();
              },
            ),
          )),
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
              physics: ScrollPhysics(),
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

                return DOListCard(
                  deliveryOrder: apiResponce.data[index],
                );
              }
              //   },

              ),
        ),
      ),
    );
  }
}

