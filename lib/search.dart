import 'package:flutter/material.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/progress_loading.dart';

class Search extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar : header(name: "Search" , titleSocialChat: false) ,
        body: circuleprogress(),
      ),
    );
  }
}

