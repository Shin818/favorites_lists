import 'dart:io';

import 'package:favorites_lists/screens/view/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/alert_dialog.dart';
import '../../common/check_list_item.dart';
import '../../common/constants.dart';
import '../../models/check_item.dart';
import '../../models/list_item.dart';
import '../add/add.dart';
import 'add_check_item/add_check_item.dart';

class ViewPage extends StatelessWidget {
  ViewPage({
    Key? key,
    this.listItem,
    this.checkItem,
  }) : super(key: key);

  ListItem? listItem;
  CheckItem? checkItem;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _showAddCheckFormPanel(
      ListItem? listItemU,
      CheckItem? checkItemU,
    ) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
            child: AddCheckItem(
              listItem: listItemU,
              checkItem: checkItemU,
            ),
          );
        },
      );
    }

    void _showEditFormPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
            child: AddPage(listItem: listItem!),
          );
        },
      );
    }

    return ChangeNotifierProvider<ViewModel>(
      create: (_) => ViewModel(listItem!)..getCheckList(listItem!),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          title: InkWell(
            onTap: () {
              _showEditFormPanel();
            },
            child: Text(listItem!.title!),
          ),
          actions: <Widget>[
            Consumer<ViewModel>(builder: (context, model, child) {
              return IconButton(
                icon: const Icon(Icons.delete_outline_outlined),
                onPressed: () => _showDialog(context, model, listItem!),
              );
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: InkWell(
                          onTap: () {
                            _showEditFormPanel();
                          },
                          child: listItem!.imageURL != null
                              ? Image.network(
                                  listItem!.imageURL!,
                                  fit: BoxFit.cover,
                                  height: 100.0,
                                  width: 100.0,
                                )
                              : const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 100.0,
                                ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     _showEditFormPanel();
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Text(
                          //       '[タグを表示する]',
                          //       style: TextStyle(fontSize: 20.0),
                          //     ),
                          //   ),
                          // ),
                          Consumer<ViewModel>(builder: (context, model, child) {
                            return IconButton(
                              icon: Icon(
                                listItem!.isFavorite!
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.pink,
                              ),
                              onPressed: () =>
                                  model.updateIsFavorite(listItem!),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SizedBox(
                  height: size.height * 0.7,
                  child: Consumer<ViewModel>(builder: (context, model, child) {
                    final checkListItem = model.checkListItem;
                    return ListView(
                      children: checkListItem
                          .map(
                            (checkItem) => checkItem.isChecked!
                                ? CheckedListCard(
                                    title: Text(checkItem.title!),
                                    onTap: () => model.updateIsChecked(
                                        listItem!, checkItem),
                                    onLongPress: () {
                                      _showAddCheckFormPanel(
                                          listItem!, checkItem);
                                    },
                                  )
                                : NotCheckedListCard(
                                    title: Text(checkItem.title!),
                                    onTap: () => model.updateIsChecked(
                                        listItem!, checkItem),
                                    onLongPress: () {
                                      _showAddCheckFormPanel(
                                          listItem!, checkItem);
                                    },
                                  ),
                          )
                          .toList(),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white),
          backgroundColor: kMainColor,
          onPressed: () {
            _showAddCheckFormPanel(listItem, checkItem);
          },
        ),
      ),
    );
  }
}

Future<void> _showDialog(
    BuildContext context, ViewModel model, ListItem listItem) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? IosAlertDialog(
              title: 'リストから削除しますか？',
              content: 'この操作は取り消せません。',
              onPressed: () async {
                await model.deleteItemList(listItem);
                await model.deleteImage(listItem);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          : AndroidAlertDialog(
              title: 'リストから削除しますか？',
              content: 'この操作は取り消せません。',
              onPressed: () async {
                await model.deleteItemList(listItem);
                await model.deleteImage(listItem);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
    },
  );
}
