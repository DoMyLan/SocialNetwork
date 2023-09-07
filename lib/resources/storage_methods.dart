import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage
  Future <String> uploadImageToStorage (String childName, Uint8List file, bool isPost) async {
    //định nghĩa đường dẫn đến tệp chứa hình ảnh .../uid/childname
    Reference ref =  _storage.ref().child(childName).child(_auth.currentUser!.uid);

    //tải dữ liệu lên đường dẫn trong Reference
    UploadTask uploadTask= ref.putData(file);

    //chứa thông tin về quá trình tải ảnh lên (bao gồm cả url file ảnh)
    TaskSnapshot snap = await uploadTask;

    //lấy đường dẫn url được lưu trữ ở firebase
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}