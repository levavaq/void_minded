import 'package:flutter/material.dart';
import 'package:void_minded/models/composition.dart';

class CompositionTile extends StatelessWidget {
  final Composition composition;

  CompositionTile({this.composition});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(composition.name),
          subtitle: Text(composition.compositor),
        ),
      ),
    );
  }
}
