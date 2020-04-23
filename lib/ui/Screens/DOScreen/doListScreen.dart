import 'package:flutter/material.dart';
import 'package:sale_order_app/config/appTheme.dart';
import 'package:sale_order_app/ui/Screens/DOScreen/doListCard.dart';
import 'package:sale_order_app/ui/Screens/deliveryChallanScreen/Widgets/listCard.dart';


class DOListScreen extends StatefulWidget {
  @override
  _DOListScreenState createState() =>
      _DOListScreenState();
}

class _DOListScreenState extends State<DOListScreen > {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(


         appBar: AppBar(
          leading: BackButton(
     color: Colors.black
   ), 
        title: Text("Delivery order",style:TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
        // backgroundColor: Theme.of(context).colorScheme.primary,
    
       // backgroundColor: AppColors.loginGradientStart,
        body: Container(
          decoration: BoxDecoration(
            
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: ListView.builder(
                // controller: lazyListscrollController,
                //  itemCount: globalItemsList.data.length,
                itemCount: 20,
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

                          return DOListCard(
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
