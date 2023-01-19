import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../common/elevated_button_widget.dart';
import '../../services/auth.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final AuthService _auth = AuthService();
  final _resetFormKey = GlobalKey<FormState>();

  String email = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Form(
          key: _resetFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text('パスワードを再設定する場合は、'),
                  Text('登録したメールアドレスを入力してください。'),
                ],
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                cursorColor: kMainColor,
                decoration: kTextInputDecoration.copyWith(hintText: 'メールアドレス'),
                validator: (val) => val!.isEmpty ? 'メールアドレスを入力してください' : null,
                onChanged: (val) => setState(() => email = val),
              ),
              const SizedBox(height: 24.0),
              AddDataButton(
                child: const Text(
                  '送信する',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_resetFormKey.currentState!.validate()) {
                    String result = await _auth.sendPasswordResetEmail(email);
                    if (result == 'success') {
                      Navigator.pop(context);
                    } else if (result == 'invalid-email') {
                      setState(() {
                        error = '無効なメールアドレスです。';
                      });
                    } else if (result == 'user-not-found') {
                      setState(() {
                        error = 'メールアドレスが登録されていません。';
                      });
                    } else if (result == 'network-request-failed') {
                      setState(() {
                        error = 'ネットに繋がっていないため、送信できませんでした。';
                      });
                    } else {
                      setState(() {
                        error = 'メール送信に失敗しました。';
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 24.0),
              Text(
                error,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
              TextButton(
                child: const Text(
                  'ログイン画面に戻る',
                  style: TextStyle(
                    color: kButtonColor,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
