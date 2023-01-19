import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosAlertDialog extends StatelessWidget {
  IosAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.onPressed})
      : super(key: key);

  final String title;
  final String content;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text('キャンセル',
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          child: const Text('OK', style: TextStyle(color: Colors.blueAccent)),
          onPressed: onPressed,
        ),
      ],
    );
  }
}

class AndroidAlertDialog extends StatelessWidget {
  AndroidAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  String? title;
  String? content;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text(content!),
      actions: <Widget>[
        TextButton(
          child: const Text('キャンセル',
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('OK', style: TextStyle(color: Colors.blueAccent)),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
