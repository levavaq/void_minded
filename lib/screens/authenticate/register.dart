import 'package:flutter/material.dart';
import 'package:void_minded/services/auth.dart';
import 'package:void_minded/shared/constants.dart';
import 'package:void_minded/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
            backgroundColor: Color(0xFF393e46),
            appBar: AppBar(
              backgroundColor: Color(0xFF222831),
              elevation: 0.0,
              title: Text("Sign up to Void Minded"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Sign in"),
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
                                  hintText: "example@gmail.com"),
                              validator: (emailValue) =>
                                  emailValue.isEmpty ? "Enter an email" : null,
                              onChanged: (emailValue) {
                                setState(() => email = emailValue);
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: "password"),
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
                              child: Text("Register"),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result = await _authService
                                      .registerWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = "Please supply a valid email";
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
                  ],
                )),
          );
  }
}
