import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar header ( {String  name , bool titleSocialChat})
{
  return AppBar(
    centerTitle: true,
    title: Text(titleSocialChat ? " Social Chat" : name ,
    style: TextStyle (color: Colors.white , fontSize: 25.0 ,fontFamily: 'Pacifico-Regular'),),
    backgroundColor:Colors.blue[700] ,
  );
}