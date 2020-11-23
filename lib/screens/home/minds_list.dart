import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:void_minded/models/mind.dart';
import 'package:void_minded/screens/home/mind_tile.dart';

class MindsList extends StatefulWidget {
  @override
  _MindsListState createState() => _MindsListState();
}

class _MindsListState extends State<MindsList> {
  @override
  Widget build(BuildContext context) {
    final minds = Provider.of<List<Mind>>(context);

    return ListView.builder(
      itemCount: minds.length,
      itemBuilder: (context, index) {
        return MindTile(mind: minds[index]);
      },
    );
  }
}
