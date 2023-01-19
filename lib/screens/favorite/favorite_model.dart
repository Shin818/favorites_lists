import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/list_item.dart';

class FavoriteModel extends ChangeNotifier {
  List<ListItem> itemList = [];

  // お気に入りのリストを取得
  void getList() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .where('isFavorite', isEqualTo: true)
        .snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final itemList = docs.map((doc) => ListItem(doc)).toList();
      itemList.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      this.itemList = itemList;
      notifyListeners();
    });
  }
}
