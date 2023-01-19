import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../models/list_item.dart';

class ListModel extends ChangeNotifier {
  List<ListItem> itemList = [];

  // 全てのリストを取得
  void getList() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final itemList = docs.map((doc) => ListItem(doc)).toList();
      itemList.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      this.itemList = itemList;
      notifyListeners();
    });
  }

  // リストから削除
  Future deleteItemList(String documentID) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .doc(documentID)
        .delete();
    notifyListeners();
  }

  // imageをstorageから削除
  Future deleteImage(ListItem listItem) async {
    String? imageName = listItem.imageName;
    FirebaseStorage storage = FirebaseStorage.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;

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
}
