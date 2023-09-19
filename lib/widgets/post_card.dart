import 'package:flutter/material.dart';
import 'package:life_post_prj/models/user.dart';
import 'package:life_post_prj/providers/user_provider.dart';
import 'package:life_post_prj/resources/firestore_methods.dart';
import 'package:life_post_prj/screens/comments_screen.dart';
import 'package:life_post_prj/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:life_post_prj/widgets/like_animation.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          //HEADER SESSION
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  //widget co lại dựa theo nội dung
                                  shrinkWrap: true,
                                  //sử dụng map để tạo ra ds các InkWell(hiệu ứng khi nhấp button)
                                  children: ['Delete']
                                      .map(
                                        (e) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16, horizontal: 12),
                                              child: Text(e),
                                            )),
                                      )
                                      .toList(),
                                ),
                              ));
                    },
                    icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),

          //IMAGE SESSION
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                  widget.snap['postId'], 
                  user.uid, 
                  widget.snap['likes']);

              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                //hiển thị theo độ mờ (1: ảnh hiển thị 100%, 0: ảnh gần như 0 hiển thị)
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 120,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),

          //LIKE + COMMENT SESSIONS

          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async{
                  await FirestoreMethods().likePost(
                  widget.snap['postId'], 
                  user.uid, 
                  widget.snap['likes']);
                  },
                  icon: widget.snap['likes'].contains(user.uid)? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ): const Icon(Icons.favorite_border, color: Colors.white,),
                ),
              ),

              IconButton(
                onPressed:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CommentsScreen())),
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_border),
                      )))
            ],
          ),

          //DESCRIPTION + NUMMBER OF COMMENTS SESSION
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TextStyle mặc định cho tất cả widget con như: kiểu chữ, kích thước chữ, color,...
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      //độ đậm của chữ
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${widget.snap['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),

                  //RichText cho phép hiển thị văn bản với các kiểu văn bản khác nhau trong cùng một widget.
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: primaryColor),
                          children: [
                        TextSpan(
                            text: widget.snap['username'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '  ${widget.snap['description']}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                ),

                // View more comments
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "View all 200 comments",
                        style: const TextStyle(
                            fontSize: 16, color: secondaryColor),
                      )),
                ),

                //Ngày post bài viết
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style: TextStyle(fontSize: 16, color: secondaryColor),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
