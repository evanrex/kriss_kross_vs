import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/services/auth.dart';
import 'package:kriss_kross_vs/shared/constants.dart';
import 'package:kriss_kross_vs/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String name = '';
  String phone = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign up for Kriss Kross'),
              actions: <Widget>[
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration:
                              testInputDecoration.copyWith(hintText: 'Name'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter your name' : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration:
                              testInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration: testInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ characters long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration:
                              testInputDecoration.copyWith(hintText: 'Phone'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter your phone number' : null,
                          onChanged: (val) {
                            setState(() => phone = val);
                          }),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          //color: Colors.pink[400],
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink[400],
                          ),
                          child: Text('Sign Up',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);

                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password, name, phone);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Invalid email or password';
                                });
                              }
                            }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
