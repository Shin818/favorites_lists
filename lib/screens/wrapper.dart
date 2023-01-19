import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/users.dart';
import 'authenticate/authentice.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
