import 'package:flutter/material.dart';
import 'package:sale_order_app/config/appTheme.dart';

class SaleOrderDetailScreenListCard extends StatelessWidget {
  //Items items;

  SaleOrderDetailScreenListCard({
    Key key,
    // this.items,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      decoration: BoxDecoration(
        // color: Colors.grey,
        // border:
        //     Border.all(color: Color.fromRGBO(250, 250, 250, 0.3), width: 1.5),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.0),
            bottomRight: Radius.circular(2.0),
            bottomLeft: Radius.circular(2),
            topRight: Radius.circular(2)),
      ),
      child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              elevation: 1,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                 
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Icon(Icons.widgets,size: 20,color: AppTheme.appBackgroundColorforCard3,),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text("Salfuric Acid FSD-MT",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: AppTheme.appBackgroundColorforCard1,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(2.0),
                                  bottomLeft: Radius.circular(0),
                                  topRight: Radius.circular(2))),
                          height: MediaQuery.of(context).size.height,
                          
                            child: Center(
                              child: Text("4577767",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11)),
                            ),
                          
                        ),
                        flex: 1,
                      )
                    ]),
              )

                  // subtitle: Text(
                  //   "DO#",
                  //   style: Theme.of(context).textTheme.body1.apply(color:Colors.grey),
                  // ),
                  // trailing: Icon(
                  //   Icons.check_circle,
                  //   color: Theme.of(context).colorScheme.secondary,
                  // ),
                  
            ),
          ),
          onTap: () {
            //    Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => DODetailScreen())
            //  );
          }),
    );
  }
}