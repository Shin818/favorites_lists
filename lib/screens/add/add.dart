import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/elevated_button_widget.dart';
import '../../models/list_item.dart';
import 'add_model.dart';

class AddPage extends StatefulWidget {
  AddPage({
    Key? key,
    this.listItem,
  }) : super(key: key);

  ListItem? listItem;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _addFormKey = GlobalKey<FormState>();
  bool _isPressed = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddModel>(
      create: (_) => AddModel(),
      child: Form(
        key: _addFormKey,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.listItem == null ? '新規リスト' : 'リストを編集',
                  style: const TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Consumer<AddModel>(builder: (context, model, child) {
              return TextFormField(
                initialValue:
                    widget.listItem == null ? '' : widget.listItem!.title,
                textAlign: TextAlign.center,
                cursorColor: kMainColor,
                decoration: kTextInputDecoration,
                autofocus: widget.listItem == null ? true : false,
                validator: (val) => val!.isEmpty ? 'タイトルを入力してください' : null,
                onChanged: (val) {
                  model.title = val;
                  // model.listItem.title = val;
                },
              );
            }),
            const SizedBox(height: 32.0),
            Consumer<AddModel>(builder: (context, model, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  onTap: () async => await model.showImagePicker(),
                  child: SizedBox(
                    height: 150.0,
                    width: 150.0,
                    child: model.imageFile != null
                        ? Image.file(
                            model.imageFile!,
                            fit: BoxFit.cover,
                          )
                        : widget.listItem != null
                            ? widget.listItem!.imageURL != null
                                ? Image.network(
                                    widget.listItem!.imageURL!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 150.0,
                                  )
                            : const Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 150.0,
                              ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 32.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Consumer<AddModel>(builder: (context, model, child) {
                  return AddDataButton(
                    child: Text(
                      widget.listItem == null ? '追加する' : '更新する',
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_isPressed) {
                        _isPressed = false;

                        if (_addFormKey.currentState!.validate()) {
                          if (widget.listItem == null) {
                            await model.addListItem();
                          } else {
                            await model.updateListItemTitle(widget.listItem!);
                          }
                          Navigator.of(context).pop();
                        }

                        _isPressed = true;
                      }
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
