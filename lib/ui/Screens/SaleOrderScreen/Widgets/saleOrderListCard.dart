import 'package:flutter/material.dart';
import 'package:sale_order_app/Models/saleOrder.dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/config/constents.dart';
import 'package:sale_order_app/ui/Screens/SaleOrderScreen/saleOrderDetailScreenListCard.dart';

class SOListCard extends StatelessWidget {

SaleOrder saleOrder;
  SOListCard({
    Key key,
     this.saleOrder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                          padding: const EdgeInsets.only(top: 12.0, bottom: 5),
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
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12))
                                            : Text(
                                                "${saleOrder.sO.toString()}",
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.w700,
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
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12))
                                            : Text("${saleOrder.date}",
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.w700,
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
                    maxHeight: 85,
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
                           items:saleOrder.items[index],

                            );
                      }
                      //   },

                      ),
                ),

                bottomPart(context,saleOrder),
                bottomButtons(context)
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
 Widget bottomPart(BuildContext context,SaleOrder saleOrder) {
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
                          child: saleOrder.balance == null ? Text("N/A", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)) : Text(
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
                          child: saleOrder.limit == null ? Text("N/A", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)) : Text(
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
                          child: saleOrder.thisSO == null ? Text("N/A", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)) : Text(
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
                          child: saleOrder.balance_ == null ? Text("N/A", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)) : Text(
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

  Widget bottomButtons(BuildContext context) {
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
                onPressed: () {},
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
                onPressed: () {},
                color: AppTheme.appBackgroundColorforCard1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                  child: Text('UnApprove',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
