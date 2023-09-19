import 'package:flutter/material.dart';
import 'package:life_post_prj/models/user.dart';
import 'package:life_post_prj/providers/user_provider.dart';
import 'package:life_post_prj/utils/colors.dart';
import 'package:life_post_prj/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments"),
        centerTitle: false,
      ),

      body: CommentCard(),

      /* SafeArea đảm bảo nội dung không bị che khuất bởi các thanh điều hướng khác */
      bottomNavigationBar: SafeArea(
        child: Container(
          //chiều cao tương đương dới thanh tiêu đề appBar
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            //truy xuất bàn phím keyboard
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                  radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Comment as ${user.username}",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: const Text('Post', style: TextStyle(color: blueColor),),
                ),
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
