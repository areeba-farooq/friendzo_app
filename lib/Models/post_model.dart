import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final datePublished;
  final String postUrl;
  final String profileImg;
  final likes;
  const PostModel({
    required this.description,
    required this.username,
    this.datePublished,
    required this.postId,
    required this.uid,
    required this.postUrl,
    required this.profileImg,
    this.likes,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "description": description,
        "uid": uid,
        "postId": postId,
        "postUrl": postUrl,
        "profileImg": profileImg,
        "datePublished": datePublished,
        'likes': likes,
      };

  //Taken document snapshot and return a user model
  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return PostModel(
      description: snapshot['description'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      uid: snapshot['uid'],
      profileImg: snapshot['profileImg'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
    );
  }
}
