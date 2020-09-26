
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_pro/Home.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/model/users.dart';
import 'package:instagram_pro/progress_loading.dart';

Future<QuerySnapshot> searchRes ;
TextEditingController searchControl = TextEditingController() ;
class Search extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Search> {
  //************** use firestore **************
  handleSearch(value){
    Future<QuerySnapshot> user = userRef.where("name" , isEqualTo: value).getDocuments();
    setState(() {
      searchRes = user ;
    });

  }
  AppBar appBarSearch(){
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        decoration: BoxDecoration(color: Colors.grey[100],borderRadius: BorderRadius.circular(30.0),),
        child: TextFormField(
          controller: searchControl,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search for a User",
            prefixIcon: Icon(Icons.account_box),
            suffixIcon: IconButton(icon: Icon(Icons.close) ,
              onPressed: (){
                //***** when make clear must declare controller (TextEditingController)************************
                searchControl.clear();
              },),),
          onFieldSubmitted:(value){
            handleSearch(value);
          },
        ),
      ),
    );
  }
  Container bodySearch(){
    //**********use oriantation عند قلب الشاشة للعرض تظهر كل المكونات *******************
    // oriant = 300 when it true screen  && the (Orientation.portrait) get width screen
    final Orientation oriant = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SvgPicture.asset("assets/images/search.svg",
                height: oriant == Orientation.portrait ? 300 :200),
            Text( "Find User ",textAlign: TextAlign.center, style: TextStyle(fontSize: 30.0,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.grey) ,)
          ],
        ),
      ),
    );
  }
  //***************appear list of user name *********
  Container bodyResultsearch(){
    return Container(
        child : FutureBuilder<QuerySnapshot>(
            future: searchRes,   //    future take documents <QuerySnapchat>
            builder:  (context , snapshot)
            {
              if (!snapshot.hasData )
              {
                return circuleprogress();
              }
              //List<Text> searchData =[];
              List<userResult> searchData =[];
              snapshot.data.documents.forEach((doc){
                User use = User.formDoc(doc);
                //searchData.add(Text(user.displayName));
                searchData.add(userResult(user : use));
              });
              return ListView(
                children: searchData,
              );
            }

        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSearch(),
      body: searchRes !=null ? bodyResultsearch():bodySearch() ,
      //body:bodySearch() ,
    );
  }
}

//************edit list user 
//************ use stateless becoause this list only appear list and go to another page
class userResult extends StatelessWidget {
  final User user ;
  userResult({this.user});
  @override
  Widget build(BuildContext context) {
    var userna = user.displayName.split(' ');

    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){},
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.grey, backgroundImage: CachedNetworkImageProvider(user.photoUrl),),
              title: (Text(userna[0],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
              subtitle:(Text(user.displayName,style: TextStyle(color: Colors.grey),)) ,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

