import 'package:firebase_auth/firebase_auth.dart';

import '../models/users.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _userFromUserCredential(User? user) =>
      user != null ? Users(uid: user.uid) : null;

  Stream<Users?> get user =>
      _auth.authStateChanges().map(_userFromUserCredential);

  // メールアドレスとパスワードでログイン
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return _userFromUserCredential(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // メールアドレスとパスワードで新規登録
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      await DatabaseService(uid: user!.uid)
          .updateUserData(user.uid, user.email!);

      return _userFromUserCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // ログアウト
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // パスワード再設定メールの送信
  Future sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }
}
