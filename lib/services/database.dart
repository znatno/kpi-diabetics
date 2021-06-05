import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_diabetics/models/brew.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:flutter_diabetics/models/glucose_record.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collections
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  //UserData({ this.uid, this.name, this.startShown, this.defaultGlucoseUnit, this.defaultMealUnit});
  // register & update settings
  Future<void> updateUserData(String name) async {

    return await userCollection.doc(uid).set({
      'name': name,
      'startShown': false,
      'defaultGlucoseUnit': "ммоль/л", // todo: add implementation
      'defaultMealUnit': "грами",    // todo: add implementation
      'glucoseCoefficient': 1,  // todo: individual coefficient chosen by doctor
    });
  }

  Future<String> getUserGC() async {
    String coef;

    await userCollection.doc(uid).get().then((snapshot) {
      coef = snapshot.data()['glucoseCoefficient'].toString();
    });

    return coef;
  }

  // TODO: додати запис прийому їжі
  Future updateFoodRecord(FoodRecord foodRecord) async {

    return await userCollection.doc(uid).collection('foodRecords')
        .doc(foodRecord.id).set(foodRecord.toMap());
  }

  // додати або оновити запис заміру цукру
  Future updateGlucoseRecord(GlucoseRecord glucoseRecord) async {

    return await userCollection.doc(uid).collection('glucoseRecords')
        .doc(glucoseRecord.id).set(glucoseRecord.toMap());
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
      defaultGlucoseUnit: snapshot.data()['defaultGlucoseUnit'] ?? "ммоль/л",
      defaultMealUnit: snapshot.data()['defaultMealUnit'] ?? "грами",
      glucoseCoefficient: snapshot.data()['glucoseCoefficient'].toString() ?? "1",
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return userCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

  /*

   TODO: зробити отримання БД (колекції) користувач своїх
         списків записів прийому їжі та замірів глюкози.
         Я так розумію, що цей клас повинен отримувати внутрішню колекцію
         з колекції користувачів.
         Відповідно, це подібно матиме наступний вигляд:
         - Stream<FoodRecord> get foodRecord  (для прийому їжі)
         - Stream<GlucoseRecord> get glucoseRecord (для заміру цукру)

   */

}