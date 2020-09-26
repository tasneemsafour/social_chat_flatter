import 'package:flutter/material.dart';

import 'Home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.lightGreen[700],
        title: Text(" Company"),
        //elevation: defaultTargetPlatform ==TargetPlatform.android ? 5.0 :0.0 ,
        /*actions: <Widget>[
          IconButton (icon:Icon( Icons.search),color: Colors.white,) ,
          IconButton (icon:Icon( Icons.notifications),color: Colors.white,) ,
        ],*/
      ),
      /* drawer:Drawer(
        child: Container(
          color: Colors.lightGreen[700],
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName:Text("Company"),
              ),

            ],
          ),
        ),
      ),*/
    );
  }
}
