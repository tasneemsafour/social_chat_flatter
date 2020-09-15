import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_pro/header.dart';



class creat_user extends StatefulWidget {
  @override
  _creat_userState createState() => _creat_userState();
}

class _creat_userState extends State<creat_user> {
   String username = " ";
  final form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:header(name: "Create User " , titleSocialChat: false),
      body: ListView(
        children :<Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 15.0),
              ),
              new Text("Creat User Name",style: TextStyle (fontSize: 25.0 )),
              new Container(
                child: Form( // form must take child and then take children
                  key: form_key,
                  child: Column(children: <Widget>[
                    new TextFormField(
                      onSaved : (val) => username=val,
                      decoration: InputDecoration(
                        labelText: "UserName",
                        hintText: "must be at 3 char  ",
                        border: OutlineInputBorder(),
                      ),
                    ),
                   Padding(
                     padding: EdgeInsets.only(top: 20.0),
                     child: MaterialButton(
                       color: Theme.of(context).primaryColor,
                       minWidth: 300.0,
                       child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 15.0 ),),
                       onPressed: (){
                         form_key.currentState.save();
                         Navigator.pop(context,username);
                       },
                     ),
                   )
                  ],),
                ),
              )
            ],),
          )
        ]
    ));
  }
}
