import 'package:flutter/material.dart';
import 'package:sale_order_app/config/appTheme.dart';

class DCDetailScreenListCard extends StatelessWidget {
  //Items items;

  DCDetailScreenListCard({
    Key key,
    // this.items,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        // color: Colors.grey,
        // border:
        //     Border.all(color: Color.fromRGBO(250, 250, 250, 0.3), width: 1.5),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(5)),
      ),
      child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.widgets,size: 20,color: AppTheme.appBackgroundColorforCard3,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Salfuric Acid FSD-MT",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: Container(
                          width: 70,
                          decoration: BoxDecoration(
                              color: AppTheme.appBackgroundColorforCard1,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(0),
                                  topRight: Radius.circular(5))),
                          height: MediaQuery.of(context).size.height,
                          
                            child: Center(
                              child: Text("4577767",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15)),
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
