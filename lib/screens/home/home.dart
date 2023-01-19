import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../add/add.dart';
import '../favorite/favorite.dart';
import '../favorite/favorite_model.dart';
import '../list/list.dart';
import '../list/list_model.dart';
import 'drawer_menu.dart';

class Home extends StatefulWidget {
  static final List<Widget> _pageList = [
    const FavoritePage(),
    const ListPage(),
  ];

  static final List<String> _titleList = [
    'お気に入り',
    '一覧',
  ];

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectIndex = 0;

  void _onItemTapped(int index) => setState(() => _selectIndex = index);

  @override
  Widget build(BuildContext context) {
    void _showAddFormPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
            child: AddPage(),
          );
        },
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoriteModel>(
            create: (_) => FavoriteModel()..getList()),
        ChangeNotifierProvider<ListModel>(
            create: (_) => ListModel()..getList()),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0.5,
          title: Text(
            Home._titleList[_selectIndex],
            style: const TextStyle(color: kMainColor),
          ),
        ),
        drawer: DrawerMenu(),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Home._pageList[_selectIndex],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kMainColor,
          onPressed: () => _showAddFormPanel(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10.0,
          selectedItemColor: kMainColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: 'お気に入り',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '一覧',
            ),
          ],
          currentIndex: _selectIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
