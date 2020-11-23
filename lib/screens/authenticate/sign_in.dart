import 'package:flutter/material.dart';
import 'package:void_minded/services/auth.dart';
import 'package:void_minded/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
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
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "example@gmail.com"),
                        validator: (emailValue) =>
                            emailValue.isEmpty ? "Enter an email" : null,
                        onChanged: (emailValue) {
                          setState(() => email = emailValue);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "password"),
                        obscureText: true,
                        validator: (passwordValue) => passwordValue.length < 6
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
                            dynamic result = await _authService
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() => error =
                                  "Could not sign in with those credentials");
                            }
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  )),
              RaisedButton(
                color: Colors.pink,
                child: Text(
                  "Sign in anonymously",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  dynamic result = await _authService.signInAnonymously();
                  if (result == null) {
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
