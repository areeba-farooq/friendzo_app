import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//to save our image to firebase storage
  Future<String> uploadFileToStorage(
      String childName, bool isPost, Uint8List file) async {
    Reference ref =
        //the reference will point to the root of the storage bucket
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      //the name of the post that unique id
      ref = ref.child(id);
    }

    //A class which indicates an on-going upload task
    UploadTask uploadTask = ref.putData(file);

//returned as the result or on-going process of a [Task].
    TaskSnapshot snap = await uploadTask;

    //fetch the downloadUrl from which file is being uploaded.
    //from this we can successfully upload our file in correct location =>
    //_storage.ref().child(childName).child(_auth.currentUser!.uid);
    //it will get into the firebase data base and display it to all the users
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
