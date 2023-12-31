import 'dart:typed_data';
import 'package:life_post_prj/models/post.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_post_prj/resources/storage_methods.dart';


class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage
  ) async{
    String res= 'Some errors occured';
    try{
      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );

      _firestore.collection('post').doc(postId).set(post.toJson());
      res = 'success';
    } catch(err){
      res= err.toString();
    }
    return res;
  }

  Future <void> likePost(String postId, String uid, List likes) async{
    try{
      if(likes.contains(uid)){
        await _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      }
      else{
        await _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    }
    catch(e){
      print(e.toString());
    }
  }
}