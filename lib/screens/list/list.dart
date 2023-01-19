import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/alert_dialog.dart';
import '../../common/list_item_tile.dart';
import '../../models/list_item.dart';
import '../view/view.dart';
import 'list_model.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListModel>(
      create: (_) => ListModel()..getList(),
      child: Consumer<ListModel>(
        builder: (context, model, child) {
          final itemLists = model.itemList;
          return Container(
            child: ListView(
              children: itemLists
                  .map(
                    (item) => ListItemTile(
                      image: item.imageURL != null
                          ? Image.network(
                              item.imageURL!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 50.0,
                            ),
                      title: Text(item.title!),
                      isFavorite: item.isFavorite!,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewPage(listItem: item))),
                      onLongPress: () => _showDialog(context, model, item),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

Future<void> _showDialog(
    BuildContext context, ListModel model, ListItem listItem) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? IosAlertDialog(
              title: 'リストから削除しますか？',
              content: 'この操作は取り消せません。',
              onPressed: () async {
                await model.deleteItemList(listItem.documentID!);
                await model.deleteImage(listItem);
                Navigator.of(context).pop();
              },
            )
          : AndroidAlertDialog(
              title: 'リストから削除しますか？',
              content: 'この操作は取り消せません。',
              onPressed: () async {
                await model.deleteItemList(listItem.documentID!);
                await model.deleteImage(listItem);
                Navigator.of(context).pop();
              },
            );
    },
  );
}
