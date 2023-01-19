import 'package:flutter/material.dart';

import 'constants.dart';

class NotCheckedListCard extends StatelessWidget {
  NotCheckedListCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  final Widget title;
  final Function() onTap;
  final Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3.0),
        decoration: kFalseDecoration,
        child: ListTile(
          title: title,
        ),
      ),
    );
  }
}

class CheckedListCard extends StatelessWidget {
  CheckedListCard({
    Key? key,
    required this.title,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  Widget? title;
  Function()? onTap;
  Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3.0),
        decoration: kTrueDecoration,
        child: ListTile(
          title: title,
        ),
      ),
    );
  }
}
