import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/location.dart';
import 'package:kriss_kross_vs/models/user.dart';
import 'package:kriss_kross_vs/screens/home/location_list.dart';
import 'package:kriss_kross_vs/screens/home/profile_form.dart';
import 'package:kriss_kross_vs/services/auth.dart';
import 'package:kriss_kross_vs/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  final AuthService _auth = AuthService();

  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: ProfileForm(),
            );
          });
    }

    return StreamProvider<List<Location>>.value(
      value: DatabaseService().locations,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Kriss Kross'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.settings),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              label: Text('Profile'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: LocationList(),
      ),
    );
  }
}
