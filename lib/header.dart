import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar header ( {String  name , bool titleSocialChat , removeBackButton = false })
{
  return AppBar(
    // if removeBackButton return true => not found return page
    automaticallyImplyLeading: removeBackButton ? false :true ,
    centerTitle: true,
    title: Text(titleSocialChat ? " Social Chat" : name ,
    style: TextStyle (color: Colors.white , fontSize: 25.0 ,fontFamily: 'Pacifico-Regular'),),
    backgroundColor:Colors.lightGreen[500],
  );
}