import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_pro/Home.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/progress_loading.dart';
import "package:timeago/timeago.dart" as timeago ;
class Activity_feed extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Activity_feed> {
  GetfeedData()async{
   QuerySnapshot snap= await feedRef.document(currentuser.id).collection("feedActive").orderBy("timeTamp",descending: true ).limit(50).getDocuments();
  List<activateFeedItem> feedItem = [];
  snap.documents.forEach((doc){
    feedItem.add(activateFeedItem.fromdoc(doc));
  });
  return feedItem;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar : header(titleSocialChat: false,name: "Activity Feed") ,
        body: FutureBuilder(
          future:  GetfeedData(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return circuleprogress();
            }
           return ListView(
             children: snapshot.data,
           );
          }
        )
      ),
    );
  }
}





class activateFeedItem extends StatelessWidget {
  final String  userId;
  final String  postId;
  final String  userName;
  final String  userProfileImage;
  final String  imgUrl;
  final String  type;
  final String  commentData;
  final Timestamp  timeTamp;

  activateFeedItem({
    this.postId,
    this.timeTamp,
    this.imgUrl,
    this.userName,
    this.userId,
    this.commentData,
    this.type,
    this.userProfileImage,
  });

   factory activateFeedItem.fromdoc(DocumentSnapshot doc){
     return activateFeedItem(
       userName: doc["userName"],
       postId : doc ["postId"],
       timeTamp :doc["timeTamp"],
       imgUrl:doc ["imgUrl"],
       userId:doc["userId"],
       commentData :doc ["commentData"],
       type :doc["type"],
       userProfileImage:doc["userProfileImage"],
     );
   }


   String activityItemText ;
   Widget mediaPreview;

   configureMedia(context)
   {

     if (type=="like" ||type== "comment")
       {
         mediaPreview = GestureDetector(
           onTap: (){},
           child: Container(
             height: 50.0,
             width: 50.0,
             child: AspectRatio(aspectRatio:16/9 ,
              child: Container(
               decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(imgUrl),
               fit: BoxFit.cover),
               ),
             ),),
           ),
         );
       }
     else {
       mediaPreview=Text(" ");
     }

     if (type=="like")
       {
         activityItemText ="liked your post";
       }
     else if(type=="comment")
     {
       activityItemText ="replied $commentData";
     }
     else if(type=="follow")
     {
       activityItemText ="is follow you";
     }
     else{
       activityItemText="error : $type";
     }
   }
  @override
  Widget build(BuildContext context) {
    configureMedia(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Container(
        child: ListTile(
          title:GestureDetector(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
                children: [
                  TextSpan(
                    text: userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " $activityItemText ",

                  ),
                ]
            ),),
          ) ,
          subtitle: Text(timeago.format(timeTamp.toDate()),overflow: TextOverflow.ellipsis,),
          trailing: mediaPreview,
        ),
      ),
    );
  }
}
