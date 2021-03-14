import 'package:flutter/material.dart';
import 'package:kriss_kross_vs/services/auth.dart';
import 'package:kriss_kross_vs/shared/constants.dart';
import 'package:kriss_kross_vs/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
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
              title: Text('Sign in to Kriss Kross'),
              actions: <Widget>[
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  icon: Icon(Icons.person),
                  label: Text('Sign up'),
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
                          validator: (val) =>
                              val.isEmpty ? 'Enter a password' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          //color: Colors.pink[400],
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink[400],
                          ),
                          child: Text('Sign In',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              print('valid');
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
