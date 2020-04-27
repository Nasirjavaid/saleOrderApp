import 'package:flutter/material.dart';
import 'package:sale_order_app/ui/Screens/SaleOrderScreen/Widgets/listCard.dart';


class SaleOrderListScreen extends StatefulWidget {
  @override
  _SaleOrderListScreenState createState() =>
      _SaleOrderListScreenState();
}

class _SaleOrderListScreenState extends State<SaleOrderListScreen > {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          leading: BackButton(
     color: Colors.black
   ), 
        title: Text("Sale order",style:TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
       // backgroundColor: AppColors.loginGradientStart,
        body:  SingleChildScrollView(
                  child: Padding(
              padding: const EdgeInsets.only(top:5.0),
              child: ListView.builder(
                  // controller: lazyListscrollController,
                  //  itemCount: globalItemsList.data.length,
                  itemCount: 10,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
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

                            return ListCard(
                     // items: thisListItems,

                     );
                  }
                  //   },

                  ),
            ),
        ),
        ),
      
    );
  }

  
}
