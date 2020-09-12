import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar header ( {String  name , bool titleSocialChat})
{
  return AppBar(
    title: Text(titleSocialChat ? " socialchat" : name ,
    style: TextStyle (color: Colors.white , fontSize: 30.0 ,fontFamily: 'Pacifico-Regular'),),
    backgroundColor:Colors.blue[700] ,
  );
}