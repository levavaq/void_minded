import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:void_minded/models/custom_user.dart';
import 'package:void_minded/models/mind.dart';

class MindService {
  final String uid;

  MindService({this.uid});

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
}
