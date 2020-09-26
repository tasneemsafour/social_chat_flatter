import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketing_shop/card.dart';
import 'package:marketing_shop/favorite.dart';
import 'package:marketing_shop/home.dart';
import 'package:marketing_shop/profile.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int pageIndex = 0 ;
  PageController pagecontroller = new PageController() ;

  @override
  void dispose()
  {
    super.dispose();
    pagecontroller.dispose();
  }

  funsetstate(int pageIndex){
    setState(() {
      this.pageIndex = pageIndex;
    });
  }
  ontap(int pageIndex){
    pagecontroller.animateToPage(pageIndex,duration: Duration (microseconds: 200),curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView(
        children: <Widget>[
          Home(),
          Cart(),
          Favorite(),
          Profile(),
        ],
        controller: pagecontroller,
        onPageChanged: funsetstate,
        physics: NeverScrollableScrollPhysics(),
      ),

      bottomNavigationBar: CupertinoTabBar(
        activeColor: Colors.black,
        currentIndex: pageIndex,
        onTap: ontap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),),
        ],
      ),
    );
  }
}
