import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_pro/Home.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/progress_loading.dart';
import 'package:instagram_pro/upload.dart';

class Comments extends StatefulWidget {
  final String postID;
  final String ownerID;
  final String imgUrl;
  Comments({this.imgUrl,this.postID,this.ownerID});

  @override
  _CommentsState createState() => _CommentsState(
    this.postID,
    this.imgUrl,
    this.ownerID,
  );
}

class _CommentsState extends State<Comments> {
  final String postID;
  final String ownerID;
  final String imgUrl;
  _CommentsState(this.postID, this.imgUrl, this.ownerID,);

  @override
  Widget build(BuildContext context) {
    TextEditingController comment_control = new TextEditingController();

    buildComments(){
      return StreamBuilder(
        stream: commentRef.document(postID).collection("comments").snapshots(),
        builder: (context,snapshots){
          if(!snapshots.data){
            return circuleprogress();
          }
          List<one_comment> commentss =[];
          snapshots.data.documents.forEach((doc){
            commentss.add(one_comment.fromDocument(doc));
          });
          return ListView(
            children: commentss,
          );
        },
      );
    };



    return Scaffold(
      appBar: header(name:"Comments",removeBackButton: true,),
      body: Column(
       children: <Widget>[
         Expanded(child: buildComments(),),
         Divider(),
         ListTile(title: TextFormField(
           controller: comment_control,
           decoration: InputDecoration(labelText: "Write a Comment"),
          ),
          trailing: OutlineButton(child:Text("Post") ,onPressed: (){
            //add comment
            commentRef.document(postID).collection("comments").add({
              "userName": currentuser.name,
              "comment" : comment_control.text,
              "userId" : currentuser.id,
              "timeStamp" : timeStamp,
              "photoUrl" : currentuser.photoUrl,
            });
            addCommentToActivity();
            comment_control.clear();
          },),
         )
       ],
      ),
    );
  }
  addCommentToActivity() {
    feedRef.document(ownerID).collection("feedActive").document(postID).setData(
        {
          "type": "comment",
          "commentData":controlText_post.text,
          "userName":currentuser.name ,
          "userId": currentuser.id,
          "userProfileImage": currentuser.photoUrl,
          "postId": postID,
          "imgUrl": imgUrl,
          "timeTamp": timeStamp,

        });
  }
}

class one_comment extends StatelessWidget {
  final String userName;
  final String userId;
  final String photoUrl;
  final String comment;
  final Timestamp timeStamp;

  one_comment({
    this.timeStamp,
    this.photoUrl,
    this.userName,
    this.comment,
    this.userId,
  });

  factory one_comment.fromDocument(DocumentSnapshot doc)
  {
    return one_comment(
      userName: doc["userName"],
      userId: doc["userId"],
      photoUrl: doc["photoUrl"],
      comment: doc["comment"],
      timeStamp: doc["timeStamp"],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(photoUrl),
          ),
          subtitle: Text(timeStamp.toDate().toString()),
        )
      ],
    );
  }
}














