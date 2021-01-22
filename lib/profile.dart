import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_pro/Home.dart';
import 'package:instagram_pro/custome_image.dart';
import 'package:instagram_pro/edit_profile.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/model/users.dart';
import 'package:instagram_pro/posts.dart';
import 'package:instagram_pro/progress_loading.dart';


class Profile extends StatefulWidget {
  User current;
  Profile({this.current});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String postView ="grid";
  final String currentUserId = currentuser.id;
  @override
  void initState(){
    super.initState();
    getPost();
    print(widget.current.name);

  }
 handleBodyProfile()
  {
   return FutureBuilder(
      future: userRef.document(widget.current.id).get(),
        builder:(context, snapshot) {
          if (!snapshot.hasData){
            print("00000000000000000000000000000000000" );
            return circuleprogress();
          }

         // User user = User.formDoc(snapshot.data);
          print("00000000000000000000000000000000000" );

          return Container(
            padding: EdgeInsets.all(20.0),

            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                      CachedNetworkImageProvider(widget.current.photoUrl),
                      radius: 40.0,
                    ),
                    Container(
                         padding: EdgeInsets.only(left: 20),
                           child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                BuildCount(name: "Posts",num: postCount.toString()),
                                 Padding(padding: EdgeInsets.all(8)),
                                BuildCount(name:"Followers",num: "0"),
                                Padding(padding: EdgeInsets.all(8)),
                                BuildCount(name:"Following",num: "0"),
                              ],
                        )
                ),],),
                 Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.current.displayName,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
                 Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.current.bio,
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ),
                 Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return editProfile(current: widget.current);
                        }));
                      },
                      child: Container(
                        width: 250.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(20.0)),
                      )),
                ),
              ],
          ));
        }
    );

  }

BuildCount({String name ,String num})
  {
    return Column(
      children: <Widget>[
       new Text (num,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        new Text (name,style: TextStyle(fontSize: 12,color: Colors.grey),),
      ],
    );
  }


 bool  isloading = true;
 int postCount = 0;
 List<Post> posts =[];
 //****************** use in initialize page
 getPost()async{
   setState(() {
     isloading = true;
   });
  QuerySnapshot snapchat =  await postRef.document(widget.current.id).collection("userPosts").orderBy("timeStamp",descending: true).getDocuments();
   setState(() {
     isloading =false;
     postCount = snapchat.documents.length;
      posts = snapchat.documents.map((doc) => Post.fromDoc(doc)).toList();
      print("************$postCount");
   });
 }

  BuildPostprofile(){
   if (isloading) {
     return circuleprogress();
   }
   else if(postView ==  "grid") {
     List<GridTile> gridTitle = [];
     posts.forEach((p) {
       gridTitle.add(GridTile(child: postTitle(p),));
     });

     return GridView.count(
       crossAxisCount: 3,
       crossAxisSpacing: 1.5,
       childAspectRatio: 1.0,
       mainAxisSpacing: 1.5,
       shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
       children: gridTitle,

     );
   }
   else if (postView == "list"){
     return Column(
       children: posts ,
     );
   }
  }
  GestureDetector postTitle(Post p){
    return GestureDetector(
      onTap: (){},
      child: CachedNetworkImage(
        imageUrl: p.imgUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: header(name: "Profile",titleSocialChat: false,removeBackButton: true),
        body: ListView(
          children: <Widget>[
           handleBodyProfile(),
            Divider(height: 2.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(icon:Icon(Icons.grid_on), onPressed: () {setState(() {postView = "grid";});}, color:postView == "grid"? Colors.lightGreenAccent :Colors.grey,),
                IconButton(icon:Icon(Icons.view_list), onPressed: () {setState(() {postView = "list";});}, color:postView== "list" ?Colors.lightGreenAccent :Colors.grey,)
              ],
            ),
            Divider(height: 2.0,),
            BuildPostprofile(),
          ],
        ),
      ),
    );
  }
}
