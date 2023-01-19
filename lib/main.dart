import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/users.dart';
import 'screens/wrapper.dart';
import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final MaterialColor materialWhite = const MaterialColor(
    0xFFf5f5f5,
    <int, Color>{
      50: Color(0xFFf5f5f5),
      100: Color(0xFFf5f5f5),
      200: Color(0xFFf5f5f5),
      300: Color(0xFFf5f5f5),
      400: Color(0xFFf5f5f5),
      500: Color(0xFFf5f5f5),
      600: Color(0xFFf5f5f5),
      700: Color(0xFFf5f5f5),
      800: Color(0xFFf5f5f5),
      900: Color(0xFFf5f5f5),
    },
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: materialWhite,
      ),
      home: StreamProvider<Users?>.value(
        value: AuthService().user,
        // initialData: Users(uid: "uid"),
        initialData: null,
        // todo:
        child: Wrapper(),
      ),
    );
  }
}
