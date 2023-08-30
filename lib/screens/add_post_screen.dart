import 'package:flutter/material.dart';
import 'package:life_post_prj/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: IconButton(
    //     icon: const Icon(Icons.upload),
    //     onPressed: (){},
    //   )
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Post',
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
        ],
      ),

      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,  //timf hieeur theem
            crossAxisAlignment: CrossAxisAlignment.start,    //timf hieeur them
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://plus.unsplash.com/premium_photo-1690481529194-6087914e096e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60'),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Write a caption...',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
