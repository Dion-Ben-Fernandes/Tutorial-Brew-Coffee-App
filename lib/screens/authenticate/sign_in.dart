import 'package:brew_crew_flutter_firebase/services/auth.dart';
import 'package:brew_crew_flutter_firebase/shared/constants.dart';
import 'package:brew_crew_flutter_firebase/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // textfield state
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
              title: Text('Sign in'),
              elevation: 0.0,
              backgroundColor: Colors.brown[900],
              actions: [
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.brown[50],
                  ),
                  label: Text(
                    'Register',
                    style: TextStyle(color: Colors.brown[50]),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              // signIn_draft RaisedButton
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    // textfield for email
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20),
                    // textfield for password
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ character'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20),
                    // button for signin
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print(email);
                          print(password);
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'please check your email or password';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      error,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
