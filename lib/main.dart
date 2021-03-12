import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/user.dart';
import 'package:kriss_kross_vs/screens/wrapper.dart';
import 'package:kriss_kross_vs/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
