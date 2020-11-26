import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:void_minded/models/note.dart';
import 'package:void_minded/screens/features/dictionnary/note_tile.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<List<Note>>(context) ?? [];

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteTile(note: notes[index]);
      },
    );
  }
}
