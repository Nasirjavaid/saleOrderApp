import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_order_app/config/appState.dart';
import 'package:sale_order_app/config/appTheme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appState.darkTheme ? ThemeMode.dark : ThemeMode.light,
          home: Settings(),
        );
      },
    );
  }
}

class Settings extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings3.dart";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {




  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
     var themeChange = Provider.of<AppState>(context);
    return Scaffold(
    
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.title
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Color",
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: 10.0),
            Card(
              color: Theme.of(context).colorScheme.primary,
              elevation: 0.5,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  // ListTile(
                  //   leading: CircleAvatar(
                  //     backgroundImage: CachedNetworkImageProvider(avatars[4]),
                  //   ),
                  //   title: Text("Damodar Lohani"),
                  //   onTap: () {},
                  // ),
                  // _buildDivider(),

                  //  Switch(
                  //     value: Provider.of<AppState>(context).isDarkModeOn,
                  //     onChanged: (booleanValue) {
                  //       Provider.of<AppState>(context).updateTheme(booleanValue);
                  //     }),
                  SwitchListTile(
                      value: themeChange.darkTheme,
                      title: Text("Dark mode",
                          style: Theme.of(context).textTheme.subtitle.apply(color:Colors.grey)),
                      onChanged: (booleanValue) {
                        // Provider.of<AppState>(context)
                        //     .updateTheme(booleanValue);
                       themeChange.darkTheme =booleanValue;
                       print("Switch value $booleanValue");
                      //themeChange.updateTheme(booleanValue);
                      //    Provider.of<AppState>(context)
                      //       .isDarkModeOn =booleanValue;
                            
                            
                      }),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Text(
            //   "PUSH NOTIFICATIONS",
            //   style: headerStyle,
            // ),
            // Card(
            //   margin: const EdgeInsets.symmetric(
            //     vertical: 8.0,
            //     horizontal: 0,
            //   ),
            //   child: Column(
            //     children: <Widget>[
            //       SwitchListTile(
            //         activeColor: Colors.purple,
            //         value: true,
            //         title: Text("Received notification"),
            //         onChanged: (val) {},
            //       ),
            //       _buildDivider(),
            //       SwitchListTile(
            //         activeColor: Colors.purple,
            //         value: false,
            //         title: Text("Received newsletter"),
            //         onChanged: null,
            //       ),
            //       _buildDivider(),
            //       SwitchListTile(
            //         activeColor: Colors.purple,
            //         value: true,
            //         title: Text("Received Offer Notification"),
            //         onChanged: (val) {},
            //       ),
            //       _buildDivider(),
            //       SwitchListTile(
            //         activeColor: Colors.purple,
            //         value: true,
            //         title: Text("Received App Updates"),
            //         onChanged: null,
            //       ),
            //     ],
            //   ),
            // ),
            // Card(
            //   margin: const EdgeInsets.symmetric(
            //     vertical: 8.0,
            //     horizontal: 0,
            //   ),
            //   child: ListTile(
            //     leading: Icon(Icons.exit_to_app),
            //     title: Text("Logout"),
            //     onTap: () {},
            //   ),
            // ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}
