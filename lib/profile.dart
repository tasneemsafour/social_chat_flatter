import 'package:flutter/material.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/progress_loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: header( name: "Profile",titleSocialChat: false),
        body: linearprogress(),
      ),
    );
  }
}
