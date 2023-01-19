import 'package:cloud_firestore/cloud_firestore.dart';

class CheckItem {
  CheckItem(DocumentSnapshot snapshot) {
    // title = snapshot.data()['title'];
    title = snapshot.get('title');
    // isChecked = snapshot.data()['isChecked'];
    isChecked = snapshot.get('isChecked');

    documentID = snapshot.id;
  }

  String? title;
  bool? isChecked;
  String? documentID;
}
