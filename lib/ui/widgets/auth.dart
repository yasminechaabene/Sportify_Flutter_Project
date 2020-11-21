
import 'package:firebase_auth/firebase_auth.dart';

import 'User.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user obj based on FirebaseUser
  User _userFromFirebaseUSer(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }



















  //Sign in with email & password
  Future signInWithemailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;




      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e);
    }
  }

  //get password
  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

//Get UID
  getCurrentUID() async {
    return (await _auth.currentUser());
  }

  //register with email & password
  Future registerWithemailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;


      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e);
    }
  }


  //sign out
  void signOut() {
    _auth.signOut();
  }




}
