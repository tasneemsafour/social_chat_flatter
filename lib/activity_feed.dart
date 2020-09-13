import 'package:flutter/material.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/progress_loading.dart';

class Activity_feed extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Activity_feed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar : header(titleSocialChat: false,name: "Activity Feed") ,
        body: circuleprogress(),
      ),
    );
  }
}
