import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../models/check_item.dart';
import '../../models/list_item.dart';

class ViewModel extends ChangeNotifier {
  ViewModel(ListItem _listItem) {
    listItem = _listItem;
    title = 'タイトル';
    isChecked = false;
  }

  ListItem? listItem;
  String? title;
  bool? isChecked;

  List<CheckItem> checkListItem = [];

  // ItemListを削除
  Future deleteItemList(ListItem listItem) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .doc(listItem.documentID)
        .delete();
    notifyListeners();
  }

  // imageをstorageから削除
  Future deleteImage(ListItem listItem) async {
    String imageName = listItem.imageName!;
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

  // checkListを追加
  Future addCheckListItem(ListItem listItem) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .doc(listItem.documentID)
        .collection('checkLists')
        .add({'title': title ?? 'タイトル', 'isChecked': isChecked ?? false});
    notifyListeners();
  }

  // checkListを更新
  Future updateCheckListItem(ListItem listItem, CheckItem checkItem) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if (title != 'タイトル') {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('lists')
          .doc(listItem.documentID)
          .collection('checkLists')
          .doc(checkItem.documentID)
          .update({'title': title});
    }
    notifyListeners();
  }

  // checkListを削除
  Future deleteCheckListItem(ListItem listItem, CheckItem checkItem) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('lists')
          .doc(listItem.documentID)
          .collection('checkLists')
          .doc(checkItem.documentID)
          .delete();
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  // isFavoriteを更新
  Future updateIsFavorite(ListItem listItem) async {
    listItem.isFavorite = !listItem.isFavorite!;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .doc(listItem.documentID)
        .update({
      'isFavorite': listItem.isFavorite,
      'updatedAt': Timestamp.now(),
    });
    notifyListeners();
  }

  // checkListを取得
  void getCheckList(ListItem listItem) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshots = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .doc(listItem.documentID)
        .collection('checkLists')
        .snapshots();

    snapshots.listen((snapshot) {
      final checkListItem = snapshot.docs.map((doc) => CheckItem(doc)).toList();
      this.checkListItem = checkListItem;
      notifyListeners();
    });
  }

  //isCheckedを更新
  Future updateIsChecked(ListItem listItem, CheckItem checkItem) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .doc(listItem.documentID)
        .collection('checkLists')
        .doc(checkItem.documentID)
        .update({'isChecked': !checkItem.isChecked!});
    notifyListeners();
  }
}
