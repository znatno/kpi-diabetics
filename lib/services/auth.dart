import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:flutter_diabetics/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on Firebase user
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential res = await _auth.signInAnonymously();
      User user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('err: sign in anon');
      print(e.toString());
      return null;
    }
  }

  // sign in email & password
  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register email & password
  Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = res.user;

      // create a new doc for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('Новий користувач', '1');

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
        return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}