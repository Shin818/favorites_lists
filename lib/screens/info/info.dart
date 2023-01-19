import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('このアプリについて'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('テーマカラー：2E4FFA'),
            Spacer(),
            Text('ご意見・ご要望などは、お問い合わせフォームからお願いいたします。'),
            Spacer(flex: 16),
          ],
        ),
      ),
    );
  }
}
