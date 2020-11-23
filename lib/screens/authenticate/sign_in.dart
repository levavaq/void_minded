import 'package:flutter/material.dart';
import 'package:void_minded/services/auth.dart';
import 'package:void_minded/shared/constants.dart';
import 'package:void_minded/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            appBar: AppBar(
              backgroundColor: Color(0xFF222831),
              elevation: 0.0,
              title: Text("Sign in to Void Minded"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Register"),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Email"),
                              validator: (emailValue) =>
                                  emailValue.isEmpty ? "Enter an email" : null,
                              onChanged: (emailValue) {
                                setState(() => email = emailValue);
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Password"),
                              obscureText: true,
                              validator: (passwordValue) =>
                                  passwordValue.length < 6
                                      ? "Enter a password 6+ chars long"
                                      : null,
                              onChanged: (passwordValue) {
                                setState(() => password = passwordValue);
                              },
                            ),
                            SizedBox(height: 20.0),
                            RaisedButton(
                              child: Text("Sign in"),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result = await _authService
                                      .signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          "Could not sign in with those credentials";
                                      loading = false;
                                    });
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                          ],
                        )),
                    RaisedButton(
                      color: Color(0xFF001818),
                      child: Text(
                        "Sign in anonymously",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() => loading = true);
                        dynamic result = await _authService.signInAnonymously();
                        if (result == null) {
                          setState(() => loading = true);
                          print("error signing in");
                        } else {
                          print("signed in");
                          print(result.uid);
                        }
                      },
                    ),
                  ],
                )),
          );
  }
}
