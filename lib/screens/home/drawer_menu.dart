import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/alert_dialog.dart';
import '../../services/auth.dart';
import '../contact/contact.dart';
import '../info/info.dart';

class DrawerMenu extends StatelessWidget {
  final AuthService? _auth = AuthService();

  final String? email = FirebaseAuth.instance.currentUser!.email;

  DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DrawerHeader(
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/image/icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        email!,
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),

                // ListTile(
                //   leading: Icon(Icons.bookmark_border_outlined),
                //   title: Text('タグ一覧'),
                //   onTap: () {},
                // ),

                // ListTile(
                //   leading: Icon(Icons.settings),
                //   title: Text('設定'),
                //   onTap: () {},
                // ),
                ListTile(
                  leading: const Icon(Icons.mail_outline),
                  title: const Text('お問い合わせ'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('このアプリについて'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InfoPage()));
                  },
                ),
                const Divider(),
              ],
            ),
            Column(
              children: [
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('ログアウト'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _showDialog(context, _auth!);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showDialog(BuildContext context, AuthService auth) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? IosAlertDialog(
              title: 'ログアウトしますか？',
              content: '',
              onPressed: () async {
                auth.signOut();
                Navigator.of(context).pop();
              },
            )
          : AndroidAlertDialog(
              title: 'ログアウトしますか？',
              content: '',
              onPressed: () async {
                auth.signOut();
                Navigator.of(context).pop();
              },
            );
    },
  );
}
