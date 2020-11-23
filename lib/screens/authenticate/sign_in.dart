import 'package:flutter/material.dart';
import 'package:void_minded/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  // text field state
  String email = "";
  String password = "";

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
                  child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    onChanged: (emailValue) {
                      setState(() => email = emailValue);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    onChanged: (passwordValue) {
                      setState(() => password = passwordValue);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text("Sign in"),
                    onPressed: () async {
                      print(email);
                      print(password);
                    },
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
