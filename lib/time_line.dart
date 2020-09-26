import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/progress_loading.dart';

final userRef = Firestore.instance.collection("users");
class Time_line extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Time_line> {
  List<dynamic> user = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    creat_user();
    getuser_asynce();
  }
 void creat_user()
  {
    userRef.document("2222").setData({"name": "heba ", "isAdmin" :false , "postCount" :2});
  }
  void update_user () async
  {
    final DocumentSnapshot doc = await userRef.document("2222").get();
    if (doc.exists){
    userRef.document("2222").updateData({"name": "heba", "isAdmin" :false , "postCount" :2});}
  }
  void delet_user()async
  {
    final DocumentSnapshot doc = await userRef.document("2222").get();
    if (doc.exists){
    userRef.document("2222").delete();}
  }
  // use querysnaopshot then documentssnapshot
  // by (then)  orrrr by (async)
  void getuser_then(){
    userRef.getDocuments().then((QuerySnapshot snapshot){
      snapshot.documents.forEach((DocumentSnapshot doc){
        print(doc.data);
        print(doc.documentID);
      });
    });
  }
  void getuser_asynce()async{
      //QuerySnapshot snapshot = await userRef.where("name", isEqualTo: "tasneem").getDocuments();
   // QuerySnapshot snapshot = await userRef.where("name", isEqualTo: "tasneem").where("isAdmin" , isEqualTo: true).where("postCount",isLessThan: 6).getDocuments();
    //QuerySnapshot snapshot = await userRef.where("postCount", isLessThanOrEqualTo: 6 ).getDocuments();
   // QuerySnapshot snapshot = await userRef.orderBy("postCount",descending: true ).getDocuments();     // from big to small
   // QuerySnapshot snapshot = await userRef.limit(2).getDocuments();    // number user we want to appear
     /* snapshot.documents.forEach((DocumentSnapshot doc){
        print(doc.data);
        print(doc.documentID);
      });*/
    QuerySnapshot snapshot = await userRef.getDocuments();
    setState(() {
      user = snapshot.documents;
      }
    );
  }
   void getuserbyid()async{
    final String id = "nYfeMdyV5zHdaGdwVcj9" ;
    DocumentSnapshot doc = await userRef.document(id).get();
    print(doc.data);
    print(doc.documentID);
    print(doc.exists);

   }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar : header(titleSocialChat: true) ,
        body: StreamBuilder<QuerySnapshot>(
             stream: userRef.snapshots(),
             builder:  (context , snapshot)
             {
               if ( ! snapshot.hasData )
                 { return circuleprogress(); }
              return ListView(
                 children : user.map((user) => Text(user["name"])).toList(),);
            }
       ) ,
      ),
    );
  }
}
  /*
   give data byyyy  list view

      body: ListView(
          children: user.map((user) => Text( user["name"] , style: TextStyle(fontSize: 20.0),)).toList()
  */
  /*
  byyy futurebuilder

   body: FutureBuilder<QuerySnapshot>(                 // future : بتاخد اللي رح نفصله     builder : بتعمل ريترن للداتا
           future: userRef.getDocuments(),   // want to reach data
           builder:  (context , snapshot)                // must take context and snapshot
           {
                if ( ! snapshot.hasData )
                {
                  return circuleprogress();
                }
                return ListView(
                  children : user.map((user) => Text(user["name"])).toList(),);
           }
       )
   */