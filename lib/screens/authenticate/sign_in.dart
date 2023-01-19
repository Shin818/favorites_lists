import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../common/elevated_button_widget.dart';
import '../../common/loading.dart';
import '../../services/auth.dart';
import '../forget_password/forget_password.dart';

class SignIn extends StatefulWidget {
  SignIn({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  Function? toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      cursorColor: kMainColor,
                      decoration:
                          kTextInputDecoration.copyWith(hintText: 'メールアドレス'),
                      validator: (val) =>
                          val!.isEmpty ? 'メールアドレスを入力してください' : null,
                      onChanged: (val) => setState(() => email = val),
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      cursorColor: kMainColor,
                      decoration:
                          kTextInputDecoration.copyWith(hintText: 'パスワード'),
                      validator: (val) =>
                          val!.length < 6 ? '６文字以上のパスワードを入力してください' : null,
                      onChanged: (val) => setState(() => password = val),
                    ),
                    const SizedBox(height: 32.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AddDataButton(
                          child: const Text(
                            'ログイン',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => isLoading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'メールアドレスまたはパスワードが違います';
                                  isLoading = false;
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      child: const Text(
                        '新規登録',
                        style: TextStyle(
                          color: kButtonColor,
                        ),
                      ),
                      onPressed: () {
                        widget.toggleView!();
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'パスワードを忘れた方',
                        style: TextStyle(
                          color: kButtonColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPassword()));
                      },
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
