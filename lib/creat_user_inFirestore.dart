import 'dart:async';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

   submitButton(){
     //***************first solution without snackbar **********
    // form_key.currentState.save();
    // Navigator.pop(context,username);
     //*************** second sol with snackbar************
     final form_state = form_key.currentState;
     if (form_state.validate())
       {
         form_state.save();
         SnackBar snackBar = SnackBar(content: Text( "Submit Successfully "),);
         _scaffoldKey.currentState.showSnackBar(snackBar);
         //**********make Timer*****************
        Timer(Duration(seconds: 2),(){
          Navigator.pop(context,username);
        });
       }

   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // key: _scaffoldKey,
      appBar:header(name: "Create User " , titleSocialChat: false,removeBackButton: true),
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
                  autovalidate: true,
                  key: form_key,
                  child: Column(children: <Widget>[
                    new TextFormField(
                      validator: (val){
                        if (val.trim().length < 3 || val.isEmpty)
                          return "the name very short";
                        else if ( val.trim().length > 12)
                          return "the name very short";
                        else
                          return null ;
                      },
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
                         submitButton();
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
