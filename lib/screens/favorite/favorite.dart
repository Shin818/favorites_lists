import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/list_item_card.dart';
import '../view/view.dart';
import 'favorite_model.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteModel>(
      create: (_) => FavoriteModel()..getList(),
      child: Consumer<FavoriteModel>(
        builder: (context, model, child) {
          final itemLists = model.itemList;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.81,
              children: itemLists
                  .map(
                    (item) => ListItemCard(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewPage(listItem: item))),
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
