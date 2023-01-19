import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/list_item.dart';

class AddModel extends ChangeNotifier {
  AddModel() {
    title = 'タイトル';
    imageURL = '';
    imageName = '';
    isFavorite = false;
    // this.imageFile = null;
  }

  String? title;
  String? imageURL;
  String? imageName;
  bool? isFavorite;
  File? imageFile;

  // FireStoreに追加
  Future addListItem() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      imageURL = await _uploadImage();
    } catch (e) {
      try {
        imageURL = await _uploadImage();
      } catch (e) {
        imageURL = "null";
        print(e.toString());
      }
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .add({
      'title': title,
      'imageURL': imageURL,
      'imageName': imageName,
      'isFavorite': isFavorite,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });

    notifyListeners();
  }

  // FireStoreを更新
  Future updateListItemTitle(ListItem listItem) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      imageURL = await _uploadImage();
    } catch (e) {
      try {
        imageURL = await _uploadImage();
      } catch (e) {
        imageURL = "null";
        print(e.toString());
      }
    }

    // titleが変更された時
    try {
      if (title != 'タイトル') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('lists')
            .doc(listItem.documentID)
            .update({
          'title': title,
        });
      }
    } catch (e) {
      print(e.toString());
    }

    // imageが変更された時（URLを変更）
    if (imageURL != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('lists')
          .doc(listItem.documentID)
          .update({
        'imageURL': imageURL,
      });

      String? imageName = listItem.imageName;
      FirebaseStorage storage = FirebaseStorage.instance;

      try {
        Reference imageRef = storage.ref().child('users/$uid/$imageName');
        await imageRef.delete();
      } catch (e) {
        Reference imageRef = storage.ref().child('users/$uid/$imageName');
        try {
          await imageRef.delete();
        } catch (e) {
          print(e.toString());
        }
      }
    }

    // imageが変更された時（名前を変更）
    if (imageName != '') {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('lists')
          .doc(listItem.documentID)
          .update({
        'imageName': imageName,
      });
    }

    notifyListeners();
  }

  // FileからImageを選択
  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(pickedFile!.path);
    notifyListeners();
  }

  // FireStorageに画像をアップロードしたら、そのURLを返す
  Future<String> _uploadImage() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    imageName =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

    final storage = FirebaseStorage.instance;
    TaskSnapshot snapshot =
        await storage.ref().child('users/$uid/$imageName').putFile(imageFile!);

    final String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
