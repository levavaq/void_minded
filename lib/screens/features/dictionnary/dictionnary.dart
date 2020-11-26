import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:void_minded/models/note.dart';
import 'package:void_minded/screens/features/dictionnary/notes_list.dart';
import 'package:void_minded/services/auth.dart';
import 'package:void_minded/services/database.dart';

class Dictionnary extends StatefulWidget {
  @override
  _DictionnaryState createState() => _DictionnaryState();
}

class _DictionnaryState extends State<Dictionnary> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Note>>.value(
      value: DatabaseService().notes,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dictionnary"),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("logout"),
              onPressed: () async {
                await _authService.signOut();
              },
            ),
          ],
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Expanded(flex: 1, child: NotesList()),
            ])),
      ),
    );
  }
}
