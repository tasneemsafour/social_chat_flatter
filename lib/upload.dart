import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_pro/Home.dart';
import 'package:instagram_pro/header.dart';
import 'package:instagram_pro/model/users.dart';
import 'package:instagram_pro/progress_loading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;

// we used it to save data in firestore
TextEditingController controlText_post = TextEditingController();
TextEditingController controlText_location = TextEditingController();



class Upload extends StatefulWidget {
  final User currentuser ;
  Upload({this.currentuser});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Upload> {
  File file_image;
  String post_id = Uuid().v4();

  Container bodyUpload(){
    return Container(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: header(name: "Upload ",titleSocialChat: false,removeBackButton: false),
            body: Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset("assets/images/upload.svg",height: 260.0,),
                Padding (padding: EdgeInsets.only(top: 70.0)),
                Container(
                  height: 55,
                  child: RaisedButton(
                    onPressed: (){ chooseImage(context);},
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                    color: Colors.lightGreen[500],
                    child: Text(" Upload image",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  ),
                )
              ],
            )
        ));
  }
  chooseImage(parentContext){
    return showDialog(
        context : context,
        builder: (context){                          // must return
          return SimpleDialog(
            title : Text("Upload Image"),
            children: <Widget>[
              SimpleDialogOption( child: Text ("Photo With Camera"),onPressed: (){camerafun();},),
              SimpleDialogOption( child: Text ("Photo From Gallery"),onPressed: (){galleryfun();},),
              SimpleDialogOption( child: Text ("Cancel"),onPressed: (){Navigator.pop(context);},)
            ],
          );
        }
    );
  }
  ImagePicker picker = ImagePicker();
  Future camerafun() async{
    Navigator.pop(context);
    print("*******************************************************************************************************");
    File file_image = await ImagePicker.pickImage(source: ImageSource.camera ,maxHeight: 675,maxWidth: 960);
    setState(() {
      this.file_image = file_image;
      print("*******************************************************************************************************");
    });
  }
  Future galleryfun() async{
    Navigator.pop(context);
    File file_image =  await ImagePicker.pickImage(source: ImageSource.gallery ,maxHeight: 675,maxWidth: 960);
    print("*******************************************************************************************************");
    setState(() {
      this.file_image = file_image;
    });
  }
  bool isUpload = false ;
  Container creat_post(){
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[500],
          actions: <Widget>[FlatButton( onPressed: (){handlePost();},child: Text ( "Post" ,style: TextStyle(color: Colors.white,fontSize: 15),),)],
          leading: IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){bodyUpload();},),
          title: Text("UploadPost",style: TextStyle(color: Colors.white),),
        ),
        body: ListView(
          children: <Widget>[
            // file_image == null ? linearprogress() : " ",
            isUpload == false ? linearprogress(): Text(" "),
            Container(
              width: MediaQuery.of(context).size.width *0.8,
              height: 220.0,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: Container(
                      decoration: BoxDecoration(image: DecorationImage(image: FileImage(file_image),fit: BoxFit.cover))
                  ),
                ),
              ),
            ),
            Padding ( padding: EdgeInsets.only(top: 20),),
            ListTile(
                leading: CircleAvatar( backgroundImage: CachedNetworkImageProvider(widget.currentuser.photoUrl),),
                title: TextField(
                  controller: controlText_post ,
                  decoration: InputDecoration(hintText: "Write Post Here", border: InputBorder.none),)
            ),
            Padding ( padding: EdgeInsets.only(top: 10 ),),
            ListTile(
                leading: Icon (Icons.pin_drop ,color: Colors.orange,),
                title: TextField(
                  // take data from textField
                  controller: controlText_location,
                  decoration: InputDecoration(hintText: "Write location Here"),)
            ),
            Padding ( padding: EdgeInsets.only(top: 20),),
            Container(
              padding: EdgeInsets.all(60),
              child: RaisedButton.icon( color : Colors.orange, onPressed:(){get_location();}, icon:Icon( Icons.my_location,color: Colors.black,),
                label: Text("Use Current Location ",style: TextStyle(color:Colors.white ),),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,),
            )
          ],
        ),
      ),
    );
  }

  get_location () async{
    //***************** position come the position in map  && picemark  come country and street and ...... ********************************
    print(" placemark is ***************************************************** ");
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placmark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark p = placmark[0];
    String full_adress = "${p.locality}" + "," + " ${p.country}";
    print(" placemark is ***************************************************** $full_adress");
    controlText_location.text= full_adress;
  }

  compressImage()async{
    //***************************save image in storage in firestore
    //**************************use UuId to convert url and compress image
    // /*********************import 'package:image/image.dart' as Im;
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile =Im.decodeImage(file_image.readAsBytesSync());
    final compressImageFile =File("$path/img_$post_id.jpg")..writeAsBytesSync(Im.encodeJpg(imageFile,quality: 85));
    setState(() {
      file_image = compressImageFile;
    });
  }

  uploadImage()async{
    StorageUploadTask uploadTask = storageRef.child("poas_$post_id.jpg").putFile(file_image);
    StorageTaskSnapshot storagesnap = await uploadTask.onComplete;
    String downloadUrl = await storagesnap.ref.getDownloadURL();
    return downloadUrl;

  }

  creat_post_firestore({String imageUrl , String description , String location}){
    // ************first create collection in firestore name post
    postRef.document(widget.currentuser.id).collection("userPosts").document(post_id).setData({
      "postID": post_id,
      "ownerID" :widget.currentuser.id,
      "userName" :widget.currentuser.name,
      "imageUrl" : imageUrl,
      "description" : description,
      "location" : location,
      "timeStamp" :timeStamp,
      "likes" :{},
    });
  }
  handlePost()async{
    setState(() {
      isUpload =true;
    });
    await compressImage();
    print ("********");
    String downloadUrl = await uploadImage();
    print ("********");
    creat_post_firestore(imageUrl: downloadUrl,description: controlText_post.text,location: controlText_location.text);
    print ("********");
    controlText_location.clear();
    controlText_post.clear();
    setState(() {
     // bodyUpload();
      isUpload=false;
      post_id=Uuid().v4();

    });


  }
  @override
  Widget build(BuildContext context) {
    return file_image == null ?bodyUpload() : creat_post() ;
    //return bodyUpload();
  }
}
