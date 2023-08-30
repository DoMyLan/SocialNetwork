import 'package:flutter/material.dart';
import 'package:life_post_prj/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:life_post_prj/models/user.dart' as model;

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Text(user.email),
        
      ),
    );
  }
}
