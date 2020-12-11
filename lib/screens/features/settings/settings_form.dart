import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:void_minded/animations/loading.dart';
import 'package:void_minded/models/custom_user.dart';
import 'package:void_minded/services/auth.dart';
import 'package:void_minded/services/mind_service.dart';
import 'package:void_minded/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final List<String> notations = ["English", "Latin"];

  // form values
  String _currentName;
  String _currentNotation;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    return StreamBuilder<CustomUserData>(
        stream: MindService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CustomUserData userData = snapshot.data;
            return Scaffold(
              backgroundColor: mainColor,
              body: Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 60.0, horizontal: 60.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text("Update your mind settings.",
                            style: TextStyle(fontSize: 18.0)),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: userData.name,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value.isEmpty ? "Please enter a name" : null,
                          onChanged: (value) =>
                              setState(() => _currentName = value),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          decoration: textInputDecoration,
                          value: _currentNotation ?? userData.notation,
                          items: notations.map((notation) {
                            return DropdownMenuItem(
                              value: notation,
                              child: Text("$notation"),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _currentNotation = value),
                        ),
                        SizedBox(height: 20.0),
                        Slider(
                          value: (_currentStrength ?? userData.strength)
                              .toDouble(),
                          activeColor: Colors
                              .blue[_currentStrength ?? userData.strength],
                          inactiveColor: Colors
                              .blue[_currentStrength ?? userData.strength],
                          min: 100.0,
                          max: 900.0,
                          divisions: 8,
                          onChanged: (value) =>
                              setState(() => _currentStrength = value.round()),
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text("Update",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await MindService(uid: user.uid).updateUserData(
                                  _currentName ?? userData.name,
                                  _currentNotation ?? userData.notation,
                                  _currentStrength ?? userData.strength);
                              Navigator.pop(context);
                            }
                          },
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white)
                          ),
                          color: mainColor,
                          child: Text("LOG OUT"),
                          onPressed: () async {
                            await _authService.signOut();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
