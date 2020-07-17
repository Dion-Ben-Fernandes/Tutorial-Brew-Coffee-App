import 'package:brew_crew_flutter_firebase/models/user.dart';
import 'package:brew_crew_flutter_firebase/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    // .map((FirebaseUser user) => (_userFromFirebaseUser(user)));
  }

  // sign in anonFuter
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('error in signInAnon()');
      return null;
    }
  }

  // sign in email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('error in signInWithEmailAndPassword()');
      print(e.toString());
      return null;
    }
  }

  // register with email ad password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print('error in registerWithEmailAndPassword()');
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('signOut() error');
      print(e.toString());
      return null;
    }
  }
}
