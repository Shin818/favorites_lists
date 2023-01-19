import 'package:flutter/material.dart';

class ListItemTile extends StatelessWidget {
  ListItemTile({
    this.key,
    this.title,
    this.image,
    this.onTap,
    this.onLongPress,
    this.isFavorite,
  });

  final Key? key;
  final Widget? title;
  final Widget? image;
  final Function()? onTap;
  final Function()? onLongPress;
  final bool? isFavorite;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          key: key,
          leading: SizedBox(
            width: 56.0,
            height: 56.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: image,
            ),
          ),
          title: title,
          onTap: onTap,
          onLongPress: onLongPress,
          trailing: isFavorite!
              ? const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                )
              : null,
        ),
        const Divider(height: 8.0),
      ],
    );
  }
}
