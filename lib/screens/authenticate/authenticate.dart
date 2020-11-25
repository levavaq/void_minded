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
            backgroundColor: mainColor,
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 150.0, horizontal: 50.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Sign in",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                ),
                              ),
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
                                        color: Colors.white,
                                        child: Text(
                                          "Sign in",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: mainColor),
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
                                        child: Text("Register",
                                            style: TextStyle(fontSize: 16.0)),
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
                  ),
                  Container(
                    height: 80,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0.0,
                                  child: Container(
                                    height: 10.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(
                              'lib/assets/images/void_minded_white_logo.png'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 10.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 26.0, horizontal: 50.0),
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "Sign in anonymously",
                          style: TextStyle(fontSize: 16.0, color: mainColor),
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
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
