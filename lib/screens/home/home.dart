import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/services/auth.dart';

class Home extends StatelessWidget {
  @override
  final AuthService _auth = AuthService();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Kriss Kross'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ));
  }
}
