import 'package:flutter/material.dart';
import 'package:instagram_pro/Home.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/posts.dart';
import 'package:instagram_pro/progress_loading.dart';


class PostScreen extends StatelessWidget {
 final String postId;
 final String userId;

 PostScreen({this.postId, this.userId});
 @override
 Widget build(BuildContext context) {
  return FutureBuilder(
   future: postRef
       .document(userId)
       .collection("userPosts")
       .document(postId)
       .get(),
   builder: (context, snapshot) {
    if (!snapshot.hasData) {
     return circuleprogress();
    }
    if (snapshot.data != null) {
     Post post = Post.fromDoc(snapshot.data);
     return Scaffold(
      appBar: header(name: post.description,titleSocialChat: false, removeBackButton: true),
      body: ListView(
       children: <Widget>[
        Container(
         child: post,
        )
       ],
      ),
     );
    } else {
     return Text("");
    }
   },
  );
 }
}
