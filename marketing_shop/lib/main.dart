import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketing_shop/body.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Body(),
    );
  }
}