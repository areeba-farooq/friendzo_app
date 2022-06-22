import 'package:flutter/material.dart';
import 'package:friendzo_app/Screens/add_post_screen.dart';
import 'package:friendzo_app/Screens/feed_screen.dart';

const webScreenSize = 600;
const homeScreenItems = [
  FeedScreen(),
  Center(child: Text("search")),
  AddPostScreen(),
  Center(child: Text("notifi")),
  Center(child: Text("profile")),
];
