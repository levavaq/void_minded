import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:void_minded/models/composition.dart';
import 'package:void_minded/screens/features/compositions/composition_tile.dart';

class CompositionsList extends StatefulWidget {
  @override
  _CompositionsListState createState() => _CompositionsListState();
}

class _CompositionsListState extends State<CompositionsList> {
  @override
  Widget build(BuildContext context) {
    final compositions = Provider.of<List<Composition>>(context) ?? [];

    return ListView.builder(
      itemCount: compositions.length,
      itemBuilder: (context, index) {
        return CompositionTile(composition: compositions[index]);
      },
    );
  }
}
