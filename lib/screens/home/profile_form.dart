import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/shared/constants.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentPhone;
  String _currentEmail;
  String _currentPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update your profile settings.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: testInputDecoration.copyWith(hintText: 'Name'),
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            decoration: testInputDecoration.copyWith(hintText: 'Phone'),
            validator: (val) =>
                val.isEmpty ? 'Please enter a phone number' : null,
            onChanged: (val) => setState(() => _currentName = val),
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
                  //setState(() => loading = true);
                  print(_currentName);
                  print(_currentPhone);
                  // print(_currentEmail);
                  // print(_currentPassword);
                }
              }),
        ],
      ),
    );
  }
}
