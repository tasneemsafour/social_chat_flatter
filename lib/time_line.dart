import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userRef = Firestore.instance.collection("users");
class Time_line extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Time_line> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser_asynce();
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
      QuerySnapshot snapshot = await userRef.getDocuments();
      snapshot.documents.forEach((DocumentSnapshot doc){
        print(doc.data);
        print(doc.documentID);
      });
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
      child: Text(" ttt"),

    );
  }
}
