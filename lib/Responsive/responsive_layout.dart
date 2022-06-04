import 'package:flutter/material.dart';
import 'package:friendzo_app/Providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../Utils/global_variables.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    //I don't want this to listen user values again n again I want to use refreshuser function once on it thats why I use listen: false;
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //webLayout
        return widget.webScreenLayout;
      }
      //Mobile layout
      return widget.mobileScreenLayout;
    });
  }
}
