import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
            resizeToAvoidBottomPadding: false,
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF001818), Color(0xFF228270)])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 80.0, horizontal: 40.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 40,
                                  child: Image(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage(
                                        'lib/assets/images/void_minded_white_logo.png'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 60.0),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Welcome to",
                                  style: textStyle.copyWith(
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Void Minded.",
                                  style: textStyle.copyWith(
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "For a better user experience please :",
                                  style: textStyle,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: textInputDecoration.copyWith(
                                  labelText: "E-Mail",
                                  hintText: "example@gmail.com",
                                  suffixIcon: Icon(Icons.alternate_email,
                                      color: Colors.white),
                                ),
                                validator: (emailValue) => emailValue.isEmpty
                                    ? "Enter an email"
                                    : null,
                                onChanged: (emailValue) {
                                  setState(() => email = emailValue);
                                },
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: textInputDecoration.copyWith(
                                  labelText: "Password",
                                  suffixIcon: Icon(
                                      Icons.account_circle_outlined,
                                      color: Colors.white),
                                ),
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
                              Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: RaisedButton(
                                        padding: EdgeInsets.symmetric(vertical: 12.0),
                                        shape: raisedButtonShape,
                                        child: Text(
                                          "SIGN IN",
                                        ),
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
                                    ),
                                  ],
                                ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                      child: Container(height: 1.0,color: Colors.white,),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "or",
                                        style: textStyle,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(height: 1.0,color: Colors.white,),
                                  ),
                                ],
                              ),
                              Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: RaisedButton(
                                        padding: EdgeInsets.symmetric(vertical: 12.0),
                                        shape: raisedButtonShape,
                                        color: mainColor,
                                        child: Text("REGISTER"),
                                        onPressed: () async {
                                          if (_formKey.currentState.validate()) {
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
                                    ),
                                  ],
                                ),
                              SizedBox(height: 12.0),
                              Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                              SizedBox(height: 50.0),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "Void Minded is now on development. If you "
                                      "encounter a problem with the application, "
                                      "please send it to the following email : "
                                      "q.levavasseur@live.fr.",
                                      style: textStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
