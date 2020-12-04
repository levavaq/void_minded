import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:void_minded/models/composition.dart';
import 'package:void_minded/models/custom_user.dart';
import 'package:void_minded/models/mind.dart';
import 'package:void_minded/models/note.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  ///*** USER SERVICE ***///

  // collection reference
  final CollectionReference mindCollection =
      FirebaseFirestore.instance.collection("minds");

  Future updateUserData(String name, String notation, int strength) async {
    return await mindCollection.doc(uid).set({
      "name": name,
      "notation": notation,
      "strength": strength,
    });
  }

  // mind list from snapshot
  List<Mind> _mindListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Mind(
        name: doc.data()["name"] ?? "",
        notation: doc.data()["notation"] ?? "",
        strength: doc.data()["strength"] ?? 0,
      );
    }).toList();
  }

  // userData from snapshot
  CustomUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return CustomUserData(
      uid: uid,
      name: snapshot.data()["name"],
      notation: snapshot.data()["notation"],
      strength: snapshot.data()["strength"],
    );
  }

  // get minds stream
  Stream<List<Mind>> get minds {
    return mindCollection.snapshots().map(_mindListFromSnapshot);
  }

  // get user doc stream
  Stream<CustomUserData> get userData {
    return mindCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  ///*** NOTE SERVICE ***///

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
