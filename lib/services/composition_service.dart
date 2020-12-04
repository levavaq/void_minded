import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:void_minded/models/composition.dart';
import 'package:void_minded/services/mind_service.dart';

class CompositionService {
  final String uid;

  CompositionService({this.uid});

  // collection reference
  final CollectionReference compositionCollection =
      FirebaseFirestore.instance.collection("compositions");

  // composition list from snapshot
  List<Composition> _compositionListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Composition(
        compositor: doc.data()["compositor"] ?? "",
        name: doc.data()["name"] ?? "",
      );
    }).toList();
  }

  // compositionData from snapshot
  Composition _compositionDataFromSnapshot(DocumentSnapshot snapshot) {
    return Composition(
      compositor: snapshot.data()["compositor"],
      name: snapshot.data()["name"],
    );
  }

  // get compositions stream
  Stream<List<Composition>> get compositions {
    Query myCompositionsCollection = FirebaseFirestore.instance
        .collection("compositions")
        .orderBy("lastModified", descending: true)
        .where("compositor", isEqualTo: MindService().mindCollection.doc(uid));

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
