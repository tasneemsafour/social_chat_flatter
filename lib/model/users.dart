import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id ;
   String name;
   String email;
   String photoUrl ;
   String displayName ;
   String bio;

  User({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio,
 });

  // return factory mean class
  // name fun (fromdoc)
  // take info from firestore and save in class user
factory User.formDoc(DocumentSnapshot doc)
{
  return User(
    id :doc["id"],
    name: doc["name"],
    email: doc["email"],
    photoUrl: doc["photoUrl"],
    displayName: doc["displayName"],
    bio: doc["bio"],
  );
}
}