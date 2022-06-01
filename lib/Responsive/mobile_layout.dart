import 'package:flutter/material.dart';
import 'package:friendzo_app/Models/user_model.dart';
import 'package:friendzo_app/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    UserModel userMod = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(child: Text(userMod.username)),
    );
  }
}
