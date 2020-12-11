import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:void_minded/models/composition.dart';

class CompositionService {
  final String uid;

  static const String COLLECTION_NAME = "compositions";

  static const String CHORDS_COLUMN = "chords";
  static const String COMPOSITOR_COLUMN = "compositor";
  static const String COMPOSITOR_NAME_COLUMN = "compositorName";
  static const String CREATION_DATE_COLUMN = "creationDate";
  static const String LAST_MODIFIED_COLUMN = "lastModified";
  static const String NAME_COLUMN = "name";

  CompositionService({this.uid});

  // collection reference
  final CollectionReference compositionCollection =
      FirebaseFirestore.instance.collection(COLLECTION_NAME);

  // composition list from snapshot
  List<Composition> _compositionListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Composition(
        compositor: doc.data()[COMPOSITOR_NAME_COLUMN] ?? "",
        name: doc.data()[NAME_COLUMN] ?? "",
      );
    }).toList();
  }

  // compositionData from snapshot
  Composition _compositionDataFromSnapshot(DocumentSnapshot snapshot) {
    return Composition(
      compositor: snapshot.data()[COMPOSITOR_COLUMN],
      name: snapshot.data()[NAME_COLUMN],
    );
  }

  // get compositions stream
  Stream<List<Composition>> get compositions {
    Query myCompositionsCollection = compositionCollection
        .orderBy(LAST_MODIFIED_COLUMN, descending: true)
        .where(COMPOSITOR_COLUMN, isEqualTo: uid);

    return myCompositionsCollection
        .snapshots()
        .map(_compositionListFromSnapshot);
  }

  // get composition doc stream
  Stream<Composition> get compositionData {
    return compositionCollection
        .doc(uid)
        .snapshots()
        .map(_compositionDataFromSnapshot);
  }
}
