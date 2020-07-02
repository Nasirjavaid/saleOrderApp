import 'package:flutter/material.dart';
import 'package:sale_order_app/Models/saleOrder.dart';
import 'package:sale_order_app/config/constents.dart';

class SaleOrderDetailScreenListCard extends StatelessWidget {
  Items items;
  SaleOrderDetailScreenListCard({
    Key key,
    this.items,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
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
            padding: const EdgeInsets.only(top: 3.0, left: 5, right: 5),
            child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)),
                elevation: 1,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  color: Color(0xFFdaeff5),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: items.itemName == null
                                ? Text("N/A",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500))
                                : Text("${items.itemName}",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w700)),
                          ),
                          Container(
                            child: items.qty == null || items.uom == null
                                ? Text("N/A",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10))
                                : Text(
                                    "${Constents.numbaerFormate.format(items.qty) + " " + items.uom.toString()}",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                          ),
                          // Text("@",
                          //     style: TextStyle(
                          //         color: Colors.black87,
                          //         fontWeight: FontWeight.w600,
                          //         fontSize: 11)),
                          Container(
                            child: items.rate == null
                                ? Text("N/A",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10))
                                : Text(
                                    " @ ${Constents.numbaerFormate.format(items.rate)} ",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                          ),
                          Container(
                            child: items.saleAmount == null
                                ? Text("N/A",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10))
                                : Text(
                                    "${Constents.numbaerFormate.format(items.saleAmount)}",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                          ),
                        ]),
                  ),
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
            //    Navigator.push("
            //   context,
            //   MaterialPageRoute(builder: (context) => DODetailScreen())
            //  );
          }),
    );
  }
}
