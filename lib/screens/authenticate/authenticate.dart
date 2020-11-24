import 'package:flutter/material.dart';
import 'package:void_minded/animations/loading.dart';
import 'package:void_minded/services/auth.dart';
import 'package:void_minded/shared/constants.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
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
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Email"),
                          validator: (emailValue) => emailValue.isEmpty
                              ? "Enter an email"
                              : null,
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
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  color: Color(0xFF001818),
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState
                                        .validate()) {
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
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: RaisedButton(
                                  child: Text("Register"),
                                  onPressed: () async {
                                    if (_formKey.currentState
                                        .validate()) {
                                      setState(() => loading = true);
                                      dynamic result = await _authService
                                          .registerWithEmailAndPassword(
                                          email, password);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                          "Please supply a valid email";
                                          loading = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(
                              color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      width: 100.0,
                      image: AssetImage(
                          'lib/assets/images/void_minded_black_logo.png'),
                    ),
                    RaisedButton(
                      color: Color(0xFF001818),
                      child: Text(
                        "Sign in anonymously",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() => loading = true);
                        dynamic result =
                        await _authService.signInAnonymously();
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
                ),
              ),
            ],
          )),
    );
  }
}
