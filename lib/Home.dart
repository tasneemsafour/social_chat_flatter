import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color :Theme.of(context).primaryColor,
            child: Column(
              children: <Widget>[
                Container (
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(top: 70.0 ,bottom: 70.0 ,left: 30.0 ),
                  child: Column (
                   children: <Widget>[
                     Text( "Login ", style: TextStyle( color: Colors.black ,fontSize: 30.0 ),),
                     Text ( " Welcom to social chat " ,style: TextStyle ( color: Colors.white ,fontSize: 20.0 ),),
                ],),),
                Expanded (
                  child: Container (
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only( topLeft : Radius.circular(50),topRight: Radius.circular(50) ),
                    ),
                    child: SingleChildScrollView (
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){},
                            child: Container(
                              margin: EdgeInsets.only(top :15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor  ,
                                borderRadius: BorderRadius.all(Radius.circular(30),)
                              ),
                              child: Text( " login with google ",style: TextStyle( fontSize: 20,color: Colors.black),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),


                )
              ],
            )
        ),
      );
  }
}
