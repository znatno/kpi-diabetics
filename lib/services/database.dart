import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_diabetics/models/brew.dart';
import 'package:flutter_diabetics/models/app_user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // brews Collection Reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String name) async {
    return await brewCollection.doc(uid).set({
      'name': name,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.data()['name'] ?? '',
      );
    }).toList();
  }

  // UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],

    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}