import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sale_order_app/CommonWidegets/commonWidgets..dart';
import 'package:sale_order_app/Models/saleOrder.dart';
import 'package:sale_order_app/Network/apiResponce.dart';
import 'package:sale_order_app/Services/saleOrderService.dart';
import 'package:sale_order_app/config/methods.dart';
import 'package:sale_order_app/ui/Screens/SaleOrderScreen/Widgets/saleOrderListCard.dart';


class SaleOrderListScreen extends StatefulWidget {
  @override
  _SaleOrderListScreenState createState() =>
      _SaleOrderListScreenState();
}

class _SaleOrderListScreenState extends State<SaleOrderListScreen > {


//Getting user service to get Summary
  SOService get soService => GetIt.I<SOService>();

  //Api responce call for Summary
  APIResponce<List<SaleOrder>> apiResponce;
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


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          leading: BackButton(
     color: Colors.black
   ), 
        title: Text("Sale order",style:TextStyle(color: Colors.black87)),
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
                        Icon(Icons.local_dining),
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
          )),
        );
      
    
  }


  Widget _buildBody(BuildContext context){

      return  SingleChildScrollView(
                  child: Padding(
              padding: const EdgeInsets.only(top:5.0),
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

                            return SOListCard(
                      saleOrder: apiResponce.data[index],

                     );
                  }
                  //   },

                  ),
            ),
        );



  }

  
}
