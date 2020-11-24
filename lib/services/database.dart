import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:void_minded/models/custom_user.dart';
import 'package:void_minded/models/mind.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference mindedCollection =
      FirebaseFirestore.instance.collection("minds");

  Future updateUserData(String sugars, String name, int strength) async {
    return await mindedCollection.doc(uid).set({
      "sugars": sugars,
      "name": name,
      "strength": strength,
    });
  }

  // mind list from snapshot
  List<Mind> _mindListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Mind(
        name: doc.data()["name"] ?? "",
        strength: doc.data()["strength"] ?? 0,
        sugars: doc.data()["sugars"] ?? "0",
      );
    }).toList();
  }

  // userData from snapshot
  CustomUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return CustomUserData(
      uid: uid,
      name: snapshot.data()["name"],
      sugars: snapshot.data()["sugars"],
      strength: snapshot.data()["strength"],
    );
  }

  // get minds stream
  Stream<List<Mind>> get minds {
    return mindedCollection.snapshots().map(_mindListFromSnapshot);
  }

  // get user doc stream
  Stream<CustomUserData> get userData {
    return mindedCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
