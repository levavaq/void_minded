import 'package:flutter/material.dart';
import 'package:void_minded/models/mind.dart';

class MindTile extends StatelessWidget {
  final Mind mind;
  MindTile({this.mind});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[mind.strength],
          ),
          title: Text(mind.name),
          subtitle: Text("Notation : ${mind.notation}"),
        ),
      ),
    );
  }
}
