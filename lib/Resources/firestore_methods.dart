import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendzo_app/Models/post_model.dart';
import 'package:friendzo_app/Resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //upload post function
  Future<String> uploadPost(
    String description,
    String uid,
    Uint8List file,
    String username,
    String profileImg,
  ) async {
    String res = 'some error occurred';
    try {
      String photoUrl =
          await StorageMethods().uploadFileToStorage('posts', true, file);
      //uuid provides you two functions
      //v1: creates a unique identifier based on the time which will give us unique id everytime
      String postId = const Uuid().v1();

      PostModel post = PostModel(
        description: description,
        username: username,
        datePublished: DateTime.now(),
        postId: postId,
        uid: uid,
        postUrl: photoUrl,
        profileImg: profileImg,
        likes: [],
      );
      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
