import 'package:flutter/material.dart';
import 'package:void_minded/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  NoteTile({this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(note.name),
        ),
      ),
    );
  }
}
