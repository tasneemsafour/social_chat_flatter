import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_pro/activity_feed.dart';
import 'package:instagram_pro/profile.dart';
import 'package:instagram_pro/search.dart';
import 'package:instagram_pro/time_line.dart';
import 'package:instagram_pro/upload.dart';

final googlesign = GoogleSignIn();
bool Authe = false;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int pageIndex = 0 ;
  PageController pagecontroller = new PageController() ;
  @override
  void initState() {
    super.initState();
    googlesign.onCurrentUserChanged.listen((account) {
      setState(() {
        Authe = true;
      });
    });
    onError(err) {
      print(" error is $err");
    }}
   // make dispose to not take a lot in cash and to pageview
  @override
  void dispose()
  {
    super.dispose();
    pagecontroller.dispose();
  }
    login() {
      googlesign.signIn();
    }
    // should go to the page requirement
    ontap(int pageIndex){
    pagecontroller.jumpToPage(pageIndex);
    }
    onpagechanged(int pageIndex){
    setState(() {
      this.pageIndex = pageIndex;
    });
    }
    // after success sign in
  // use page view to go to another page and taken children widget
    Widget build_outo_screen() {
      return Scaffold(
        body: PageView(
          children: <Widget>[
            Time_line(),
            Activity_feed(),
            Upload(),
            Search(),
            Profile(),
          ],
          controller: pagecontroller,
          onPageChanged: onpagechanged,
          // not scroll
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CupertinoTabBar(
          activeColor: Colors.blue,
          currentIndex: pageIndex,
          onTap: ontap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot),),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),),
          ],
        ),
      );
    }
    Widget build_in_outo_screen() {
      return Scaffold(
        body: Container(
            color: Theme
                .of(context)
                .primaryColor,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(top: 70.0, bottom: 70.0, left: 30.0),
                  child: Column(
                    children: <Widget>[
                      Text("Login ",
                        style: TextStyle(color: Colors.black, fontSize: 30.0),),
                      Text(" Welcom to social chat ",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),),
                    ],),),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              login();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),)
                              ),
                              child: Text(" login with google ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),),
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

    @override
    Widget build(BuildContext context) {
      // Authe ? true condition : false condition
      return Authe ? build_outo_screen() : build_in_outo_screen();
    }
}


