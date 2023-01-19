import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/alert_dialog.dart';
import '../../../common/constants.dart';
import '../../../common/elevated_button_widget.dart';
import '../../../models/check_item.dart';
import '../../../models/list_item.dart';
import '../view_model.dart';

class AddCheckItem extends StatefulWidget {
  AddCheckItem({
    Key? key,
    required this.listItem,
    required this.checkItem,
  }) : super(key: key);

  ListItem? listItem;
  CheckItem? checkItem;

  @override
  _AddCheckItemState createState() => _AddCheckItemState();
}

class _AddCheckItemState extends State<AddCheckItem> {
  final _addItemKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (_) => ViewModel(widget.listItem!),
      child: Form(
        key: _addItemKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.checkItem == null ? '新規チェックリスト' : 'チェックリストを編集',
                  style: const TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Consumer<ViewModel>(builder: (context, model, child) {
              return TextFormField(
                initialValue:
                    widget.checkItem == null ? null : widget.checkItem!.title,
                autofocus: widget.checkItem == null ? true : false,
                textAlign: TextAlign.center,
                cursorColor: kMainColor,
                decoration: kTextInputDecoration,
                validator: (val) => val!.isEmpty ? 'テキストを入力してください' : null,
                onChanged: (val) {
                  model.title = val;
                },
              );
            }),
            const SizedBox(height: 48.0),
            Consumer<ViewModel>(builder: (context, model, child) {
              return AddDataButton(
                child: Text(
                  widget.checkItem == null ? '追加する' : '更新する',
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_addItemKey.currentState!.validate()) {
                    if (widget.checkItem == null) {
                      await model.addCheckListItem(widget.listItem!);
                    } else {
                      await model.updateCheckListItem(
                          widget.listItem!, widget.checkItem!);
                    }

                    Navigator.of(context).pop();
                  }
                },
              );
            }),
            const SizedBox(height: 24.0),
            Consumer<ViewModel>(builder: (context, model, child) {
              return widget.checkItem == null
                  ? Container()
                  : DeleteDataButton(
                      child: const Text(
                        '削除する',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => _showDialog(
                          context, model, widget.listItem!, widget.checkItem!),
                    );
            }),
          ],
        ),
      ),
    );
  }
}

Future<void> _showDialog(BuildContext context, ViewModel model,
    ListItem listItem, CheckItem checkItem) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? IosAlertDialog(
              title: '削除しますか？',
              content: 'この操作は取り消せません。',
              onPressed: () async {
                await model.deleteCheckListItem(listItem, checkItem);

                final nav = Navigator.of(context);
                nav.pop();
                nav.pop();
              },
            )
          : AndroidAlertDialog(
              title: '削除しますか？',
              content: 'この操作は取り消せません。',
              onPressed: () async {
                await model.deleteCheckListItem(listItem, checkItem);
                final nav = Navigator.of(context);
                nav.pop();
                nav.pop();
              },
            );
    },
  );
}
