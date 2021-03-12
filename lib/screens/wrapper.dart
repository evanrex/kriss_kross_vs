import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/user.dart';
import 'package:kriss_kross_vs/screens/home/home.dart';
import 'package:kriss_kross_vs/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
    //return either Home or Authenticate widget
  }
}
