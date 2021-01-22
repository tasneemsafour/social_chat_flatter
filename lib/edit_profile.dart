import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_pro/Home.dart';
import 'package:instagram_pro/model/users.dart';

class editProfile extends StatefulWidget {
  User current;
  editProfile({this.current});
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  TextEditingController control_namefull= TextEditingController();
  TextEditingController control_bio = TextEditingController();
  TextEditingController control_name = TextEditingController();

  bool _validBoi = true;
  bool _validName= true;
  bool _validfullName = true;

  final _scaffeldKey = GlobalKey<ScaffoldState>();

  Container TextFieldDisplayName( {String name ,String hint ,TextEditingController controll,bool valid , String errorText}){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(name,style: TextStyle(color: Colors.black,fontSize: 15),),
          ),
          TextField(
            controller:controll ,
            decoration: InputDecoration(
              hintText: hint,
              errorText: valid == true ? null : errorText ,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  saveEdit() async{
    setState(() {
      control_bio.text.trim().length > 50 ? _validBoi = false : _validBoi= true;
      control_name.text.trim().length >10 ? _validName = false : _validName= true;
      control_namefull.text.trim().length < 5 ? _validfullName = false : _validfullName= true;
    });
      if (_validfullName && _validName && _validBoi) {
        userRef.document(widget.current.id).updateData({
          "name": control_name.text,
          "displayName": control_namefull.text,
          "bio": control_bio.text
        });
      }
      //************************ snackbar
    // *************************must have key scaffold
    SnackBar snack = SnackBar(content: Text ("uodate Profile"),);
      _scaffeldKey.currentState.showSnackBar(snack);

   /* widget.current.displayName = control_namefull.text;
    widget.current.bio=control_bio.text;
    widget.current.name=control_name.text;*/

    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffeldKey,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Edit Profile"),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10,right: 150,left: 150),
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: CachedNetworkImageProvider(widget.current.photoUrl),
                backgroundColor: Colors.grey,
              ),
          ),
          TextFieldDisplayName(name: "Full Name :",controll: control_namefull,hint: "Update Display Name",valid: _validfullName,errorText: "Full Name short"),
          TextFieldDisplayName(name: "Name :",controll: control_name,hint: "Update Name",valid: _validName,errorText: "Name very long"),
          TextFieldDisplayName(name: "Bio :",controll: control_bio,hint: "Update Bio",valid: _validBoi,errorText: "Bio very long"),
          Padding ( padding: EdgeInsets.all(10.0),),
          FlatButton(
            child: Container( child: Text("Update Profile" ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Colors.lightGreen),
              width: 250.0,
              height: 30.0,
              alignment: Alignment.center,),
            onPressed: (){
              saveEdit();
            },
          ),
          Padding(padding: EdgeInsets.all(20.0),),
          FlatButton.icon(onPressed: (){
            googlesign.signOut();
            Navigator.push(context, MaterialPageRoute(builder: ((context) {return Home();})));
            },
              icon: Icon(Icons.cancel,color: Colors.black,),
              label: Text("Logout",style: TextStyle(color: Colors.black,fontSize: 20.0),))
        ],
      ),
    );
  }
}
