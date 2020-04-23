import 'package:flutter/material.dart';
import 'package:sale_order_app/ui/Screens/DOScreen/doDetailScreen.dart';





class DOListCard extends StatelessWidget {

  //Items items;

  DOListCard({
    Key key,
   // this.items,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child:Card(
        color: Colors.white,
    elevation: 2.0,
    margin: new EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
    child: Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child:  ListTile(
      contentPadding: EdgeInsets.only(left: 10.0, right: 15.0,),
      leading: Container(
        padding: EdgeInsets.only(right: 0.0),
        // decoration: new BoxDecoration(
        //     border: new Border(
        //         right: new BorderSide(width: 1.0, color: Colors.black26))),
        child: Container(
          height: 40,
          width: 40,
          child: Center(
            child: Material(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: Icon(Icons.person,
                                        color: Colors.white70, size: 20.0),
                                  ))),
          ),
        ),
      ),
      title:  Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Text(  "Hamad Ali", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
      ) ,
     // : Text("N/A",style: AppTypographyStyles.smallTextStyleNotVailable), 
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Padding(
        padding: const EdgeInsets.only(top:3.0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           //  items.dcNo !=null ?
              Text("Item purchased", style: Theme.of(context).textTheme.body1, ) ,
              //: Text("N/A",style:AppTypographyStyles.smallTextStyle),
          //  items.dcDate !=null ? Text(DateTimeConverter.getDateAndTime(items.dcDate), style: AppTypographyStyles.smallTextStyle) :Text("N/A",style:AppTypographyStyles.smallTextStyle),
             
             
             
             Text("D0 # : 4367", style: Theme.of(context).textTheme.body1, ) ,
             Row(children: <Widget>[
              Spacer(),
              
             // items.status !=null ?
              // Text(items.status, style: AppTypographyStyles.smallTextStyle.apply(color:Color.fromRGBO(28, 192, 159, .9))) :
               Text("12-03-2020",style: Theme.of(context).textTheme.body1,),

          ],)
          ],
         
        ),
      ),
      // trailing:
      //     Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: (){
            
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DODetailScreen())
           );
            
            }

    ),
      ),));
    
  }
  }




