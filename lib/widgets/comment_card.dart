import 'package:flutter/material.dart';
import 'package:life_post_prj/models/user.dart';
import 'package:life_post_prj/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://phongvu.vn/cong-nghe/wp-content/uploads/2022/12/hinh-nen-messi-2.png'),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: user.username,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      TextSpan(
                        text: '  Some comments will stay here',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w100)
                      )
                    ])),
            
            
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        '19/09/2023',
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.favorite, size: 16,),
            )
          ],

          
        ));
  }
}
