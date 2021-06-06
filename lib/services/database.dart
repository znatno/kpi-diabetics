import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> updateUserData(String name, String glucoseCoefficient) async {

    return await userCollection.doc(uid).set({
      'name': name,
      'startShown': false,
      'defaultGlucoseUnit': "ммоль/л", // todo: add implementation
      'defaultMealUnit': "грами",    // todo: add implementation
      'glucoseCoefficient': 1.0,
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
    print(foodRecord.toMap());

    return await userCollection.doc(uid).collection('foodRecords')
        .doc(foodRecord.id).set(foodRecord.toMap());
  }

  // додати або оновити запис заміру цукру
  Future updateGlucoseRecord(GlucoseRecord glucoseRecord) async {

    return await userCollection.doc(uid).collection('glucoseRecords')
        .doc(glucoseRecord.id).set(glucoseRecord.toMap());
  }

  // GlucoseRecords list from snapshot
  List<GlucoseRecord> _glucoseListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return GlucoseRecord(
        id: doc.id ?? 'err',
        amount: doc.data()['amount'] ?? 'err',
        normality: doc.data()['normality'] ?? 'err',
        recommend: doc.data()['recommend'] ?? 'err',
        timestamp: doc.data()['timestamp'].toDate() ?? 'err',
        type: doc.data()['type'] ?? 'err',
        units: doc.data()['units'] ?? 'err',
      );
    }).toList();
  }

  // FoodRecords list from snapshot
  List<FoodRecord> _foodListFromSnapshot(QuerySnapshot snapshot) {


    return snapshot.docs.map((doc) {
      return FoodRecord(
        id: doc.id ?? 'err',
        foodList: doc.data()['foodList'].split(',') ?? 'err',
        recommendedDose: doc.data()['recommendedDose'] ?? 'err',
        timestamp: doc.data()['timestamp'].toDate() ?? 'err',
        totalCarbs: doc.data()['totalCarbs'] ?? 'err',
        type: doc.data()['type'] ?? 'err',
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

  // get GlucoseRecords stream
  Stream<List<GlucoseRecord>> get glucoseRecords {
    return userCollection.doc(uid).collection('glucoseRecords').snapshots()
        .map(_glucoseListFromSnapshot);
  }

  // get FoodRecords stream
  Stream<List<FoodRecord>> get foodRecords {
    return userCollection.doc(uid).collection('foodRecords').snapshots()
        .map(_foodListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}