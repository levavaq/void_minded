import 'package:flutter/material.dart';
import 'package:void_minded/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Sign in to Void Minded")),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text("Sign in anonymously"),
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
      ),
    );
  }
}
