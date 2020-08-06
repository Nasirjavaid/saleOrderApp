import 'package:flutter/material.dart';
import 'package:sale_order_app/config/appTheme.dart';



class DCDetailScreen extends StatefulWidget {
  @override
  _DCDetailScreenState createState() => _DCDetailScreenState();
}

class _DCDetailScreenState extends State<DCDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 10,
      // decoration: BoxDecoration(
      //   gradient: new LinearGradient(
      //       colors: [Color(0xFF2193b0), Color(0xFF3a7bd5)],
      //       begin: Alignment(1.0, 0.0),
      //       end: Alignment(0.0, 1.0),
      //       stops: [0.0, 1.0],
      //       tileMode: TileMode.clamp),
      // ),
      child: Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          elevation: 0.0,
          leading: BackButton(color: Colors.white),
          title: Text("Vision Plus",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600)),
          backgroundColor: Color(0xFF2193b0),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(0)),
                gradient: new LinearGradient(
                    colors: [Color(0xFF2193b0), Color(0xFF3a7bd5)],
                    begin: Alignment(0.0, 0.0),
                    end: Alignment(0.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(child: buildBody()),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(children: <Widget>[
      Card(
          color: AppTheme.appBackgroundColorforCard1,
          elevation: 20,
          // decoration: BoxDecoration(
          //   // color: Colors.grey,
          //   border: Border.all(
          //       color: Color.fromRGBO(250, 250, 250, 0.3), width: 1.5),
          //   borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(2.0),
          //       bottomRight: Radius.circular(2.0),
          //       bottomLeft: Radius.circular(2),
          //       topRight: Radius.circular(2)),
          //   gradient: new LinearGradient(
          //       colors: [Colors.white, AppTheme.appBackgroundColor],
          //       begin: Alignment(1.0, 3.0),
          //       end: Alignment(0.0, 0.0),
          //       // begin: const FractionalOffset(0.0, 1.0),
          //       // end: const FractionalOffset(1.0, 1.0),
          //       stops: [0.0, 2.0],
          //       tileMode: TileMode.clamp),
          // ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Text(
                //   "Sales",
                //   style: Theme.of(context).textTheme.title,
                // ),
                Row(children: <Widget>[
                  Text("DO# :",
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                          fontSize: 13)),
                  SizedBox(
                    width: 5,
                  ),
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
                            child: Text("4567",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18))),
                      )),
                ]),
                Row(children: <Widget>[
                  // Text("Date :",
                  //     style: TextStyle(
                  //         color: Colors.white70,
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 13)),
                  // SizedBox(
                  //   width: 5,
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
                            child: Text("18-April-2020",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15))),
                      )),
                ])
              ],
            ),
          )),
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
       
         
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
          //       colors: [AppTheme.appBackgroundColor, Color(0xFF2193b0)],
          //       begin: Alignment(1.0, 3.0),
          //       end: Alignment(0.0, 0.0),
          //       // begin: const FractionalOffset(0.0, 1.0),
          //       // end: const FractionalOffset(1.0, 1.0),
          //       stops: [0.0, 2.0],
          //       tileMode: TileMode.clamp),
          // ),
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 30,
                maxHeight: 285,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      // controller: lazyListscrollController,
                      //  itemCount: globalItemsList.data.length,
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        // Items thisListItems = globalItemsList
                        //  .data[index];
                        // (snapshot.data[snapshot.data.length - index].title);
                        //  if (index == globalItemsList.data.length - 1) {
                        print("length matched");
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

                        // return DODetailScreenListCard(
                        //     // items: thisListItems,

                        //     );
                      }
                      //   },

                      ),
                ),
              ),
            ),
          ),
        ),
      
      bottomPart(context),
      bottomButtons(context)
    ]);
  }

  Widget bottomPart(BuildContext context) {
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
      padding: const EdgeInsets.only(top:8.0),

      child: Row(
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
                padding: const EdgeInsets.all(12.0),
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
                              fontSize: 12)),

                      SizedBox(height:5),
                       Flexible(
                        child: new SizedBox(
                          // width: 40,
                          // height: 30,
                          child: new Text("8963443",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                        ),
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
                    colors: [Color(0xFF43cea2), Color(0xFF2193b0)],
                    begin: Alignment(0.0, 1.0),
                    end: Alignment(0.0, 0.0),
                    // begin: const FractionalOffset(0.0, 1.0),
                    // end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 2.0],
                    tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                              fontSize: 12)),

                      SizedBox(height:5),
                       Flexible(
                        child: new SizedBox(
                          // width: 40,
                          // height: 30,
                          child: new Text("8963443",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                        ),
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
                    colors: [Color(0xFF43cea2), Color(0xFF2193b0)],
                    begin: Alignment(0.0, 1.0),
                    end: Alignment(0.0, 0.0),
                    // begin: const FractionalOffset(0.0, 1.0),
                    // end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 2.0],
                    tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                              fontSize: 12)),

                      SizedBox(height:5),
                       Flexible(
                        child: new SizedBox(
                          // width: 40,
                          // height: 30,
                          child: new Text("8963443",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                        ),
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
                    colors: [Color(0xFF43cea2), Color(0xFF2193b0)],
                    begin: Alignment(0.0, 1.0),
                    end: Alignment(0.0, 0.0),
                    // begin: const FractionalOffset(0.0, 1.0),
                    // end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 2.0],
                    tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                              fontSize: 12)),

                      SizedBox(height:5),
                       Flexible(
                        child: new SizedBox(
                          // width: 40,
                          // height: 30,
                          child: new Text("8963443",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
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
        padding: const EdgeInsets.only(top: 25.0, bottom: 5, right: 5, left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Text("           ",style: Theme.of(context).textTheme.title,),
            //Container()
      Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 0),
      child: RaisedButton(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () {
         
        },
       
        
        color: AppTheme.appBackgroundColorforCard5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:3.0,horizontal: 19),
          child: Text('Approve', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),




          Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 0),
      child: RaisedButton(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () {
         
        },
       
        
        color: AppTheme.appBackgroundColorforCard5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:3.0,horizontal: 12),
          child: Text('UnApprove', style: TextStyle(color: Colors.white)),
        ),
      ),
    )
          ],
        ),
      ),
    );
  }
}
