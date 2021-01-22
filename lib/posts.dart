import 'dart:async';
import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_pro/Home.dart';
import 'package:instagram_pro/model/comments.dart';
import 'package:instagram_pro/model/users.dart';
import 'package:instagram_pro/progress_loading.dart';

class Post extends StatefulWidget {
  final String description ;
  final String imgUrl;
  final dynamic likes;
  final String location ;
  final String ownerID;
  final String postID ;
  final String userName;
  final Timestamp timeTamp ;

  Post({
   this.location,
   this.description,
    this.imgUrl,
    this.likes,
    this.ownerID,
    this.postID,
    this.timeTamp,
    this.userName,
});
  factory Post.fromDoc(DocumentSnapshot doc){
    return Post(
      location: doc["location"],
      description: doc["description"],
      imgUrl: doc["imgUrl"],
      ownerID : doc["ownerID"],
      postID: doc["postID"],
      userName: doc["userName"],
      timeTamp: doc["timeTamp"],
      likes: doc["likes"],
    );
  }
  int getCountPost(likes)
  {

    if (likes == null) {
      return 0 ;
    }
      int count = 0;
      likes.values.forEach((k){
        if (k== true){
          count+=1;
        }
      });
      return count ;
  }
  @override
  _PostState createState() => _PostState(
    location: this.location,
    description:this.description,
    imgUrl:this.imgUrl,
    likes:this.likes,
    ownerID:this.ownerID,
    postID:this.postID,
    timeTamp:this.timeTamp,
    userName:this.userName,
    likeCount: getCountPost(this.likes),
  );

}

class _PostState extends State<Post> {
  String currentuserid = currentuser?.id ;     // ? use if the id null not make error
  final String description ;
  final String imgUrl;
  Map likes;
  final String location ;
  final String ownerID;
  final String postID ;
  final String userName;
  final Timestamp timeTamp ;
  int likeCount ;
  bool islike ;

  _PostState({
    this.location,
    this.description,
    this.imgUrl,
    this.likes,
    this.ownerID,
    this.postID,
    this.timeTamp,
    this.userName,
    this.likeCount,
  });
   buildPostHeader()
  {
    return FutureBuilder<DocumentSnapshot>(
      future: userRef.document(ownerID).get(),
      builder:(context, snapshot){
        if(! snapshot.hasData)
          {
            return circuleprogress();
          }
        User user = User.formDoc(snapshot.data);
        return Container(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){},
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.grey, backgroundImage: CachedNetworkImageProvider(user.photoUrl),),
                  title: (Text(user.displayName[0],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                  subtitle:(Text(location,style: TextStyle(color: Colors.grey),)) ,
                  trailing: IconButton(icon: Icon(Icons.more_vert),),
                ),
              ),
              Container(
                child: Text(description),
              ),
            ],
          ),
        );
      }
    );
  }

  bool show_heart = false ;
  buildImage(){
     //*******when press on image will appear favorite so ====>>>>> use stack
     return Stack (
       alignment: Alignment.center,
       children: <Widget>[
         GestureDetector(
           //*********** when pressed in image change likes also
           onTap: (){ PreserdLike();},

           child: CachedNetworkImage(imageUrl:imgUrl ,height: 300.0,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
         ),
         show_heart ?Animator(
           duration: Duration(milliseconds: 300),
           curve: Curves.easeInOut,
           tween: Tween(begin: 0.8 , end: 1.4),
           cycles: 0,          // repeats
           builder: (context, anim, child ) => Transform.scale(scale: anim.value,
             child: Icon(Icons.favorite , size: 170.0 , color: Colors.red) ,),
         )
             : Text(" ") ,
         // Icon(Icons.favorite , size: 170.0 , color: Colors.red,):Text(" "),
       ],
     );
  }

  buildFooter(){
     return Column(
       children: <Widget>[
         Container(
           margin: EdgeInsets.only(left: 20.0,top: 20.0),
           child: Text("$likeCount Likes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
         ),
         Divider(),
         Container(
           child: Row(
             mainAxisAlignment:MainAxisAlignment.spaceEvenly,
             children: <Widget>[
               Container(
                 child:  GestureDetector(
                   onTap:(){PreserdLike();},
                   child: Row(
                     children: <Widget>[
                       IconButton(icon: Icon(islike ?Icons.favorite : Icons.favorite_border ,size: 20.0,color: Colors.red,),),
                       Padding(padding: EdgeInsets.only(left: 5.0),),
                       Text("Likes"),
                     ],
                   ),
                 ),
               ),
               Container(
                 child:  Container(
                   child: GestureDetector(
                     onTap:(){
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return Comments(postID:postID , ownerID:ownerID,imgUrl:imgUrl);
                       }));
                      },
                     child: Row(
                       children: <Widget>[
                         Icon(Icons.mode_comment,size: 20.0,color: Colors.black,),
                         Padding(padding: EdgeInsets.only(left: 5.0),),
                         Text("Comment"),
                       ],
                     ),
                   ),
                 ),
               ),
               Container(
                 child:  Row(
                   children: <Widget>[
                     IconButton(icon: Icon(Icons.share,size: 20.0,color: Colors.black,),),
                     Padding(padding: EdgeInsets.only(left: 5.0),),
                     Text("Share"),
                   ],
                 ),
               )
             ],
           ),
         )
       ],
     );
  }

  addLikeToActivity()
  {
    feedRef.document(ownerID).collection("feedActive").document(postID).setData(
        {
          "type": "like",
          "userName":currentuser.name,
          "userId" :currentuser.id,
          "userProfileImage":currentuser.photoUrl,
          "postId":postID,
          "imgUrl":imgUrl,
          "timeTamp":timeTamp,

        });
  }
  removeLikeFromActivity(){
    feedRef.document(ownerID).collection("feedActive").document(postID).get().then((doc){
      if(doc.exists)
        {
          doc.reference.delete();
        }
    });
  }


  PreserdLike(){
     //********** like take current user and boolean true or false =>>>> map
     bool _islike = likes[currentuserid] == true ;
     //***********  when pressed change from true to false
     if (_islike == true )
       {
         postRef.document(ownerID).collection("userPosts").document(postID).updateData({'likes$currentuserid' : false});
         removeLikeFromActivity();
         setState(() {
           likeCount -= 1 ;
           islike = false;
           likes[currentuserid] = false;
           show_heart = true ;
         });
         Timer(Duration(milliseconds: 500),(){
           setState(() {
             //********** after 5 sec make show heart = false
             show_heart = false ;
           });
         });
       }
     else {
       postRef.document(ownerID).collection("userPosts").document(postID).updateData({'likes$currentuserid' : true});
       addLikeToActivity();
       setState(() {
         likeCount +=1 ;
         islike = true;
         likes[currentuserid] = true;
       });
     }
  }
  @override
  Widget build(BuildContext context) {
    islike = likes[currentuserid] == true ;
    return Container(
      child: Column(
        children: <Widget>[
          buildPostHeader(),
          buildImage(),
          buildFooter(),
        ],
      ),
    );
  }
}

PreserdComment(context,{String postID,String ownerID,String imgUrl})
{
  
}