import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/models/user.dart';
import 'package:kriss_kross_vs/services/database.dart';
import 'package:kriss_kross_vs/shared/constants.dart';
import 'package:kriss_kross_vs/shared/loading.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentPhone;
  //String _currentEmail;
  //String _currentPassword;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<Object>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            //_currentName = userData.name;
            //_currentPhone = userData.phone;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your profile settings.',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: testInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.phone,
                    decoration: testInputDecoration.copyWith(hintText: 'Phone'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a phone number' : null,
                    onChanged: (val) => setState(() => _currentPhone = val),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentPhone ?? userData.phone,
                              userData.email);
                          Navigator.pop(context);
                        }
                      }),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
