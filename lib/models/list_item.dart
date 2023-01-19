import 'package:cloud_firestore/cloud_firestore.dart';

class ListItem {
  ListItem(DocumentSnapshot snapshot) {
    // title = snapshot.data()['title'];
    // imageURL = snapshot.data()['imageURL'];
    // imageName = snapshot.data()['imageName'];
    // isFavorite = snapshot.data()['isFavorite'];
    // documentID = snapshot.id;
    // createdAt = snapshot.data()['createdAt'].toDate();
    // updatedAt = snapshot.data()['updatedAt'].toDate();
    title = snapshot.get('title');
    imageURL = snapshot.get('imageURL');
    imageName = snapshot.get('imageName');
    isFavorite = snapshot.get('isFavorite');
    documentID = snapshot.id;
    createdAt = snapshot.get('createdAt').toDate();
    updatedAt = snapshot.get('updatedAt').toDate();
  }

  String? title;
  String? imageURL;
  String? imageName;
  bool? isFavorite;
  String? documentID;
  DateTime? createdAt;
  DateTime? updatedAt;
}
