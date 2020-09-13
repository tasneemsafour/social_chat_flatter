import 'package:flutter/material.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/progress_loading.dart';

class Upload extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar : header(name: "Upload" ,titleSocialChat: false) ,
        body: circuleprogress(),
      ),
    );
  }
}
