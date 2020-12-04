import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:void_minded/models/note.dart';

class NoteService {
  final String uid;

  NoteService({this.uid});

  // collection reference
  final CollectionReference mindCollection =
  FirebaseFirestore.instance.collection("notes");

  // queries
  final Query sNoteEnCollection = FirebaseFirestore.instance
      .collection("notes")
      .orderBy("nameEng")
      .where("bemol", isEqualTo: false);
  final Query sNoteLatCollection = FirebaseFirestore.instance
      .collection("notes")
      .orderBy("nameLat")
      .where("bemol", isEqualTo: false);
  final Query bNoteEnCollection = FirebaseFirestore.instance
      .collection("notes")
      .orderBy("nameEng")
      .where("sharp", isEqualTo: false);
  final Query bNoteLatCollection = FirebaseFirestore.instance
      .collection("notes")
      .orderBy("nameLat")
      .where("sharp", isEqualTo: false);

  // note list from snapshot
  List<Note> _notesEnListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      print(doc.data()["nameEng"]);
      return Note(
        name: doc.data()["nameEng"] ?? "",
      );
    }).toList();
  }

  List<Note> _notesLatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Note(
        name: doc.data()["nameLat"] ?? "",
      );
    }).toList();
  }

  // get notes streams
  Stream<List<Note>> get sNotesEn {
    return sNoteEnCollection.snapshots().map(_notesEnListFromSnapshot);
  }

  Stream<List<Note>> get sNotesLat {
    return sNoteLatCollection.snapshots().map(_notesLatListFromSnapshot);
  }

  Stream<List<Note>> get bNotesEn {
    return bNoteEnCollection.snapshots().map(_notesEnListFromSnapshot);
  }

  Stream<List<Note>> get bNotesLat {
    return bNoteLatCollection.snapshots().map(_notesLatListFromSnapshot);
  }
}
