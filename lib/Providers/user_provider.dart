import 'package:flutter/cupertino.dart';
import 'package:friendzo_app/Models/user_model.dart';
import 'package:friendzo_app/Resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userModel; //private variable
  final AuthMethods _authMethods = AuthMethods(); //instance

  UserModel get getUser =>
      _userModel!; //to get the data from this private variable

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _userModel = user;
    //it will notify all the listners of this user provider that the data of our global variable user has changed. So yo need to update your value.
    notifyListeners();
  }
}
