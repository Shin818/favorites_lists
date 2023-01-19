import 'package:flutter/material.dart';

class ListItemCard extends StatelessWidget {
  ListItemCard({
    Key? key,
    required this.onTap,
    required this.image,
    required this.title,
  }) : super(key: key);

  Function()? onTap;
  Widget? image;
  Widget? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: image,
                ),
              ),
            ),
            Flexible(
              child: DefaultTextStyle(
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                child: title!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
