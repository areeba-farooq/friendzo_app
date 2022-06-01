import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String bio;
  final String username;
  final String photoUrl;
  final List following;
  final List followers;
  const UserModel({
    required this.email,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.uid,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "bio": bio,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following
      };

  //Taken document snapshot and return a user model
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return UserModel(
        email: snapshot['email'],
        username: snapshot['username'],
        bio: snapshot['bio'],
        photoUrl: snapshot['photoUrl'],
        uid: snapshot['uid'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }
}
