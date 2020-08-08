import 'package:flutter/material.dart';


class SaleOrderForm extends StatefulWidget {
  @override
  _SaleOrderFormState createState() => _SaleOrderFormState();
}

class _SaleOrderFormState extends State<SaleOrderForm> {

   final _formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   String dropDownCurrentValue;
  static final List<String> dropdownItemsList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5'
  ];

  





  // String actualDropdown = dropdownItemsList[0];
  int actualChart;


  String itemSalesTax,itemAmount,itemRate,itemDescription;



    void showMessage(String message, [MaterialColor color = Colors.blue]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message,style: TextStyle(fontWeight:FontWeight.w700),),duration: const Duration(seconds:1),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   elevation: 0,
      //   // leading: Padding(
      //   //   padding: const EdgeInsets.all(16.0),
      //   //   child: Icon(Icons.menu),
      //   // ),
      //   actions: <Widget>[

      //   ],
      // ),
      body: Form(
        key: _formKey,
              child: Padding(
          padding: EdgeInsets.only(
            top: 12.0,
            left: 10.0,
            right: 10.0,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("Sale order",
                        style: Theme.of(context).textTheme.display1),
                    // GestureDetector(
                    //   child: Icon(
                    //     Icons.settings,
                    //   ),
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => Settings()),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 16.0),
              //   child: Card(
              //     color: Theme.of(context).colorScheme.primary,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20)),
              //     elevation: 4,
              //     margin: const EdgeInsets.symmetric(horizontal: 20),
              //     child: ListTile(
              //       leading: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Icon(
              //           Icons.call,
              //           color: Theme.of(context).iconTheme.color,
              //         ),
              //       ),
              //       title: Text(
              //         "Conference Call",
              //         style: Theme.of(context).textTheme.subhead,
              //       ),
              //       subtitle: Text(
              //         "30 mins",
              //         style: Theme.of(context).textTheme.body1.apply(color:Colors.grey),
              //       ),
              //       trailing: Icon(
              //         Icons.check_circle,
              //         color: Theme.of(context).colorScheme.secondary,
              //       ),
              //     ),
              //   ),
              // ),
              // Spacer(),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Row(
              //     children: <Widget>[
              //       Text(
              //         'Dark Mode',
              //         style: Theme.of(context).textTheme.body2,
              //       ),
              //       Spacer(),
              //       // Switch(
              //       //     value: Provider.of<AppState>(context).isDarkModeOn,
              //       //     onChanged: (booleanValue) {
              //       //       Provider.of<AppState>(context).updateTheme(booleanValue);
              //       //     }),
              //     ],
              //   ),
              // ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.only(top:35.0,left: 8,right: 8),
              //       child: saleOrdrNumber(context),
              //     ),
              //       Padding(
              //   padding: const EdgeInsets.only(top:0.0,left: 8,right: 8),
              //   child:customerName(context),
              // ),
              //   ],
              // ),
            
              IntrinsicHeight(
                  child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
                child: firstRowWithSaleOrderAndCustomerName(context),
              )),

              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: address(context)),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: salePerson(context)),

              IntrinsicHeight(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: secondRowWithCurentBalanceAndCraditLimit(context),
              )),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: dropDownList(context)),

              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: etDescription(context)),

              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: therdRoWithItemRateAndSalesTax(context))),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: forthdRoWithItemQuantityAndAmount(context))),

              Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, left: 10, right: 10, bottom: 15),
                  child: Align(child: roundedCornerButton(context))),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstRowWithSaleOrderAndCustomerName(BuildContext context) {
    return Container(
      height: 35,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: new Padding(
              padding: const EdgeInsets.all(0.0),
              child: saleOrdrNumber(context),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          new Padding(
            padding: const EdgeInsets.all(0.0),
            child: Align(
                alignment: Alignment.bottomRight, child: customerName(context)),
          ),
        ],
      ),
    );
  }

  Widget saleOrdrNumber(BuildContext context) {

    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width * 0.5,
        child: TextFormField(
          
          cursorColor: Colors.grey,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          //controller: firstNameTextController,
          //validator: _validateFirstName,
          maxLength: 300,
          style: Theme.of(context).textTheme.body2,
          decoration: InputDecoration(
             errorStyle: TextStyle(height: 0),
           // helperText: '  ',
              counterText: "",
              // prefixIcon: Icon(
              //   Icons.map,
              //   size: 15,
              //   color: Theme.of(context).colorScheme.secondary,
              // ),
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              border: const OutlineInputBorder(
                  borderSide: const BorderSide(

                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
              // hintText: "Sale order #",
              labelText: "Sale order no",
              labelStyle: Theme.of(context).textTheme.body1,
              hintStyle: Theme.of(context)
                  .textTheme
                  .subtitle
                  .apply(color: Colors.grey),
              // hintStyle: TextStyle(
              //   fontSize: 12,
              //   color: Color.fromRGBO(64, 75, 96, .9),
              //   //fontFamily: ScreensFontFamlty.FONT_FAMILTY
              // ),
              filled: false,
              fillColor: Theme.of(context).colorScheme.primary,
              // errorStyle: Theme.of(context)
              //     .textTheme
              //     .subtitle
              //     .apply(color: Colors.grey)
                  ),
          validator: (String state) {
            if (state.isEmpty) {
              return "";
            } else {
              return null;
            }
          },
        ));
  }

  Widget customerName(BuildContext context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width * 0.5,
        child: TextFormField(
          cursorColor: Colors.grey,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          //controller: firstNameTextController,
          //validator: _validateFirstName,
          maxLength: 300,
          style: Theme.of(context).textTheme.body2,
          decoration: InputDecoration(
             errorStyle: TextStyle(height: 0),
              counterText: "",
              // prefixIcon: Icon(
              //   Icons.map,
              //   size: 15,
              //   color: Theme.of(context).colorScheme.secondary,
              // ),
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              border: const OutlineInputBorder(
                  borderSide: const BorderSide(

                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              // hintText: "Sale order no",
              labelText: "Customer name",
              labelStyle: Theme.of(context).textTheme.body1,
              // hintStyle: Theme.of(context)
              //     .textTheme
              //     .subtitle
              //     .apply(color: Colors.grey),
              // hintStyle: TextStyle(
              //   fontSize: 12,
              //   color: Color.fromRGBO(64, 75, 96, .9),
              //   //fontFamily: ScreensFontFamlty.FONT_FAMILTY
              // ),
              filled: false,
              fillColor: Theme.of(context).colorScheme.primary,
           
                  
                  ),
          validator: (String state) {
            if (state.isEmpty) {
              return "";
            } else {
              return null;
            }
          },
        ));
  }

  Widget address(BuildContext context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width * 0.5,
        child: TextFormField(
          cursorColor: Colors.grey,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          //controller: firstNameTextController,
          //validator: _validateFirstName,
          maxLength: 300,
          style: Theme.of(context).textTheme.body2,
          decoration: InputDecoration(
              counterText: "",
              // prefixIcon: Icon(
              //   Icons.map,
              //   size: 15,
              //   color: Theme.of(context).colorScheme.secondary,
              // ),
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              border: const OutlineInputBorder(
                  borderSide: const BorderSide(

                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              // hintText: "Sale order no",
              labelText: "Address",
              labelStyle: Theme.of(context).textTheme.body1,
              // hintStyle: Theme.of(context)
              //     .textTheme
              //     .subtitle
              //     .apply(color: Colors.grey),
              // hintStyle: TextStyle(
              //   fontSize: 12,
              //   color: Color.fromRGBO(64, 75, 96, .9),
              //   //fontFamily: ScreensFontFamlty.FONT_FAMILTY
              // ),
              filled: false,
              fillColor: Theme.of(context).colorScheme.primary,
              errorStyle: TextStyle(height: 0),),
          validator: (String state) {
            if (state.isEmpty) {
              return "";
            } else {
              return null;
            }
          },
        ));
  }

  Widget secondRowWithCurentBalanceAndCraditLimit(BuildContext context) {
    return Container(
      height: 35,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: new Padding(
              padding: const EdgeInsets.all(0.0),
              child: currentBalance(context),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          new Padding(
              padding: const EdgeInsets.all(0.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: craditLimit(context))),
        ],
      ),
    );
  }

  Widget salePerson(BuildContext context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width * 0.5,
        child: TextFormField(
          cursorColor: Colors.grey,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          //controller: firstNameTextController,
          //validator: _validateFirstName,
          maxLength: 300,
          style: Theme.of(context).textTheme.body2,
          decoration: InputDecoration(
              counterText: "",
              // prefixIcon: Icon(
              //   Icons.map,
              //   size: 15,
              //   color: Theme.of(context).colorScheme.secondary,
              // ),
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              border: const OutlineInputBorder(
                  borderSide: const BorderSide(

                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              // hintText: "Sale order no",
              labelText: "Sale person",
              labelStyle: Theme.of(context).textTheme.body1,
              // hintStyle: Theme.of(context)
              //     .textTheme
              //     .subtitle
              //     .apply(color: Colors.grey),
              // hintStyle: TextStyle(
              //   fontSize: 12,
              //   color: Color.fromRGBO(64, 75, 96, .9),
              //   //fontFamily: ScreensFontFamlty.FONT_FAMILTY
              // ),
              filled: false,
              fillColor: Theme.of(context).colorScheme.primary,
              errorStyle: TextStyle(height: 0),),
          validator: (String state) {
            if (state.isEmpty) {
              return "";
            } else {
              return null;
            }
          },
        ));
  }

  Widget currentBalance(BuildContext context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width * 0.5,
        child: TextFormField(
          cursorColor: Colors.grey,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          //controller: firstNameTextController,
          //validator: _validateFirstName,
          maxLength: 300,
          style: Theme.of(context).textTheme.body2,
          decoration: InputDecoration(
              counterText: "",
              // prefixIcon: Icon(
              //   Icons.map,
              //   size: 15,
              //   color: Theme.of(context).colorScheme.secondary,
              // ),
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              border: const OutlineInputBorder(
                  borderSide: const BorderSide(

                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              // hintText: "Sale order no",
              labelText: "Current balance",
              labelStyle: Theme.of(context).textTheme.body1,
              // hintStyle: Theme.of(context)
              //     .textTheme
              //     .subtitle
              //     .apply(color: Colors.grey),
              // hintStyle: TextStyle(
              //   fontSize: 12,
              //   color: Color.fromRGBO(64, 75, 96, .9),
              //   //fontFamily: ScreensFontFamlty.FONT_FAMILTY
              // ),
              filled: false,
              fillColor: Theme.of(context).colorScheme.primary,
              errorStyle: TextStyle(height: 0),),
          validator: (String state) {
            if (state.isEmpty) {
              return "";
            } else {
              return null;
            }
          },
        ));
  }

  Widget craditLimit(BuildContext context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width * 0.5,
        child: TextFormField(
          cursorColor: Colors.grey,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          //controller: firstNameTextController,
          //validator: _validateFirstName,
          maxLength: 300,
          style: Theme.of(context).textTheme.body2,
          decoration: InputDecoration(
              counterText: "",
              // prefixIcon: Icon(
              //   Icons.map,
              //   size: 15,
              //   color: Theme.of(context).colorScheme.secondary,
              // ),
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              border: const OutlineInputBorder(
                  borderSide: const BorderSide(

                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              // hintText: "Sale order no",
              labelText: "Cradit limit",
              labelStyle: Theme.of(context).textTheme.body1,
              // hintStyle: Theme.of(context)
              //     .textTheme
              //     .subtitle
              //     .apply(color: Colors.grey),
              // hintStyle: TextStyle(
              //   fontSize: 12,
              //   color: Color.fromRGBO(64, 75, 96, .9),
              //   //fontFamily: ScreensFontFamlty.FONT_FAMILTY
              // ),
              filled: false,
              fillColor: Theme.of(context).colorScheme.primary,
               errorStyle: TextStyle(height: 0),),
          validator: (String state) {
            if (state.isEmpty) {
              return "";
            } else {
              return null;
            }
          },
        ));
  }

  Widget dropDownList(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width - 200,
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(64, 75, 96, .9)),
          //color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
              bottomLeft: Radius.circular(5),
              topRight: Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 5),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).colorScheme.background,
          ),
          child: DropdownButton(
              underline: Text(""),
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Theme.of(context).iconTheme.color,
              ),
              hint: Text(
                "Select item",
                style: Theme.of(context).textTheme.body1,
              ),
              isDense: true,
              value: dropDownCurrentValue,
              onChanged: (String value) => setState(() {
                   // actualDropdown = value;
                    dropDownCurrentValue =value;
                    // actualChart =
                    //     dropdownItemsList.indexOf(value); // Refresh the chart

                    //itemRate = itemRateList.indexOf(value);
                  }),
              items: dropdownItemsList.map((String title) {
                return DropdownMenuItem(
                  value: title,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child:
                        Text(title, style: Theme.of(context).textTheme.body2),
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }

  Widget etDescription(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Row(
        //scrollDirection: Axis.horizontal ,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(64, 75, 96, .9)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    "Item description",
                    // style: Theme.of(context).textTheme.body2),
                  ))),
          // etWeddingDate,

          // SizedBox(
          //   height: 2.0,
          // ),
          // SizedBox(width: 10,),
          //  Container(
          //    height: MediaQuery.of(context).size.height,
          //    width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width*0.5,

          //      decoration: BoxDecoration(
          // border: Border.all(color: Color.fromRGBO(64, 75, 96, .9)),
          // color: Colors.white,
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(5.0),
          //     bottomRight: Radius.circular(5.0),
          //     bottomLeft: Radius.circular(5),
          //     topRight: Radius.circular(5))),

          //    child: Center(child: Text("Item rate"))),
        ],
      ),
    );
  }

  Widget therdRoWithItemRateAndSalesTax(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //scrollDirection: Axis.horizontal ,
        children: <Widget>[
          Expanded(
            child: Container(
                height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width -
                //     MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(64, 75, 96, .9)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: itemRate == null ? Text(
                    "Item rate",
                  ): Text(itemRate),
                )),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
                height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width -
                //     MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(64, 75, 96, .9)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text("Sales tax"),
                )),
          ),
        ],
      ),
    );
  }

  Widget forthdRoWithItemQuantityAndAmount(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //scrollDirection: Axis.horizontal ,
        children: <Widget>[
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: itemQuantity(context)),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
                height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width -
                //     MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(64, 75, 96, .9)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text("Amount"),
                )),
          ),
        ],
      ),
    );
  }

  Widget itemQuantity(BuildContext context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width * 0.5,
        child: TextFormField(
          cursorColor: Colors.grey,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          //controller: firstNameTextController,
          //validator: _validateFirstName,
          maxLength: 300,
          style: Theme.of(context).textTheme.body2,
          decoration: InputDecoration(
              counterText: "",
              // prefixIcon: Icon(
              //   Icons.map,
              //   size: 15,
              //   color: Theme.of(context).colorScheme.secondary,
              // ),
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              border: const OutlineInputBorder(
                  borderSide: const BorderSide(

                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(
                      // color: Color.fromARGB(255, 232, 232, 232),
                      color: Color.fromRGBO(64, 75, 96, .9),
                      width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              // hintText: "Sale order no",
              labelText: "Quantity",
              labelStyle: Theme.of(context).textTheme.body1,
              // hintStyle: Theme.of(context)
              //     .textTheme
              //     .subtitle
              //     .apply(color: Colors.grey),
              // hintStyle: TextStyle(
              //   fontSize: 12,
              //   color: Color.fromRGBO(64, 75, 96, .9),
              //   //fontFamily: ScreensFontFamlty.FONT_FAMILTY
              // ),
              filled: false,
              fillColor: Theme.of(context).colorScheme.primary,
              errorStyle: TextStyle(height: 0),),
          validator: (String state) {
            if (state.isEmpty) {
              return "";
            } else {
              return null;
            }
          },
        ));
  }

  Widget roundedCornerButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: new BoxDecoration(
          //color:  Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Theme.of(context).colorScheme.primary,
        //     offset: Offset(1.0, 6.0),
        //     blurRadius: 20.0,
        //   ),
        //   BoxShadow(
        //     color: Theme.of(context).colorScheme.primary,
        //     offset: Offset(1.0, 3.0),
        //     blurRadius: 10.0,
        //   ),
        // ],
        // gradient: new LinearGradient(
        //     colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary],
        //     begin: const FractionalOffset(0.2, 0.2),
        //     end: const FractionalOffset(1.0, 1.0),
        //     stops: [0.0, 1.0],
        //     tileMode: TileMode.clamp),
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(64, 75, 96, .9)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5),
                topRight: Radius.circular(5))),
        child: MaterialButton(
            highlightColor: Theme.of(context).colorScheme.primary,
            splashColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 42.0),
              child: Text("Save & Apply",
                  style: Theme.of(context).textTheme.body2),
            ),
            onPressed: () {
              print("Submit button pressed");

              if (_formKey.currentState.validate()) {
                //   // If the form is valid, display a Snackbar.
                //  Scaffold.of(context).showSnackBar(snackBar);
                //   Navigator.push(
                //   context,
                //  // MaterialPageRoute(builder: (context) => HomeScreen()),
                // );
                 if(dropDownCurrentValue== null)
              {
                showMessage("Please select Item");
                return;
              }else
              {
                showMessage("Submitted");
                return;
              }
              }
            }
            // showInSnackBar("Login button pressed")

            ),
      ),
    );
  }
}
