import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ListTile listDrewer({IconData icon , String text}){
    return ListTile(
      leading: Icon(icon,color: Colors.white,),
      title: Text(text ,style: TextStyle(color: Colors.white,),),
    );
  }
  ListTile ListTilehorizontall({IconData icon , String text}){
    return ListTile(
      // title: Image.asset(name),
      title: Icon(Icons.ac_unit),
      subtitle: Text(text ,style:TextStyle (color: Colors.white,),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
       appBar : AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(" Company",style: TextStyle(color: Colors.black)),
      //elevation: defaultTargetPlatform ==TargetPlatform.android ? 5.0 :0.0 ,
        actions: <Widget>[
        IconButton (icon:Icon( Icons.search,color: Colors.black,),color: Colors.white,) ,
        IconButton (icon:Icon( Icons.notifications,color: Colors.black),color: Colors.white,) ,
      ],
    ),
       drawer:Drawer(
         child: Container(
           color: Colors.lightGreen[700],
           child: ListView(
            children: <Widget>[
            ListTile(
              trailing: Icon(Icons.clear,color: Colors.white,size: 20,),
               title: Text("Company" ,style: TextStyle(color: Colors.white,fontSize: 25)),),
             listDrewer(icon: Icons.phone , text: "+91 98765432210"),
              Divider(color: Colors.white,),
              listDrewer(icon: Icons.account_balance_wallet , text: "My Wallet"),
              listDrewer(icon: Icons.view_list , text: "My Orders"),
              listDrewer(icon: Icons.local_offer , text: "Offers"),
              listDrewer(icon: Icons.cached, text: "Refer"),
              listDrewer(icon: Icons.exit_to_app, text: "LogOut"),
              listDrewer(icon: Icons.wb_auto , text: "About Us"),
              listDrewer(icon: Icons.star_border , text: "Rate Us"),
              listDrewer(icon: Icons.share , text: "Share"),
              Divider(color: Colors.white),
    ],),),),
        body: Container(
          color: Colors.grey[300],
          child: ListView(
            children: <Widget>[
              Container(
                child : Row(
                 children: <Widget>[
                  Container(
                   padding: EdgeInsets.only(left: 20,top: 15,right: 200),
                   child: Text("Discover",)
                   ),
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30),
                     ),
                       child: RaisedButton(
                         textColor: Colors.white,
                         padding: EdgeInsets.all(0.5),
                          onPressed: (){},
                         child: Text("See All",style: TextStyle(fontSize: 10),),color: Colors.lightGreen[700],)
                   ), ], ),),
              Container(
                child : ListView (
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ListTilehorizontall( text: "Shampoo"),
                    ListTilehorizontall( text: "Oil"),
                    ListTilehorizontall( text: "Bascuits"),
                    ListTilehorizontall( text: "juce"),
                ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
