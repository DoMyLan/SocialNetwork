import 'package:flutter/material.dart';
import 'package:life_post_prj/screens/add_post_screen.dart';
import 'package:life_post_prj/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('SearchView'),
  AddPostScreen(),
  Text('PersonalView'),
  Text('AddCircleView'),
];
