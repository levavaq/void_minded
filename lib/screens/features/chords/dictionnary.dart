import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:void_minded/animations/loading.dart';
import 'package:void_minded/models/custom_user.dart';
import 'package:void_minded/models/note.dart';
import 'package:void_minded/screens/features/dictionnary/notes_list.dart';
import 'package:void_minded/services/auth.dart';
import 'package:void_minded/services/mind_service.dart';
import 'package:void_minded/services/note_service.dart';

class Dictionnary extends StatefulWidget {
  @override
  _DictionnaryState createState() => _DictionnaryState();
}

class _DictionnaryState extends State<Dictionnary> {
  final AuthService _authService = AuthService();

  Stream<List<Note>> getList(CustomUserData userData) {
    if (userData.notation != "Latin") {
      return NoteService().sNotesEn;
    } else {
      return NoteService().sNotesLat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    return StreamBuilder<CustomUserData>(
        stream: MindService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CustomUserData userData = snapshot.data;
            return StreamProvider<List<Note>>.value(
              value: getList(userData),
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
          } else {
            return Loading();
          }
        });
  }
}
