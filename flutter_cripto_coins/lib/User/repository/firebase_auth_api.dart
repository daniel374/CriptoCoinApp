import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    User userCredential = (await _auth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: gSA.idToken, accessToken: gSA.accessToken,)
    )) as User;

    return userCredential;

    //notifyListener();
  }
  // Sign Up with email and password
  Future<User> signUp(String email, String password) async {
    try{
      var auth = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign In with email and password
  Future<User> signIn(String email, String password) async {
    try{
      var auth = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut().then((value) => print("Sessión cerrada"));
    googleSignIn.signOut();
    print("Sesiones cerradas");
  }

  // check Sign In
  Future<void> isSignedIn() async {
    var currentUser = await _auth.currentUser;
    return currentUser != null;
  }

  // get current user
  Future<void> getCurrentUser() async {
    return await _auth.currentUser;
  }
}