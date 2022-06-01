import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:friendzo_app/Models/user_model.dart';
import 'package:friendzo_app/Resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//**************To get the user detials Function****************//
  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    return UserModel.fromSnap(snap);
  }

//**************SignUp Function****************//
  Future<String> getSignUp({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file,
  }) async {
    String res = " some error occoured!";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty) {
        //**************Reguster User****************//
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (kDebugMode) {
          print(credential.user!.uid);
        }

//**************Upload profile picture****************//
        String photoUrl = await StorageMethods()
            .uploadFileToStorage("profilePics", false, file);

//**************UserModel Instance****************//
        UserModel userModel = UserModel(
          email: email,
          username: username,
          bio: bio,
          photoUrl: photoUrl,
          uid: credential.user!.uid,
          followers: [],
          following: [],
        );

//**************Save user credentials to database****************//
        await _firestore
            .collection("users")
            .doc(credential.user!.uid)
            .set(userModel.toJson());
        res = "success";
      } else {
        res = 'Please enter all the fields';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'email-already-in-use') {
        return res = 'Invalid email address';
      } else if (err.code == 'week-password') {
        return res = 'Provided password is too week';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //**************Login User Function****************//
  Future<String> getLogin({
    required String email,
    required String password,
  }) async {
    String res = 'Some Error Occurred!';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential creds = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(creds.user!.email);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        return res = "No user found with that email address";
      } else if (err.code == 'wrong-password') {
        return res = 'Wrong password provided by the user.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
