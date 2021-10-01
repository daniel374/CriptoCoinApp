import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    User userCredential = (await _auth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: gSA.idToken, accessToken: gSA.accessToken,)
    )) as User;

    return userCredential;

    //notifyListener();
  }

  signOut() async {
    await _auth.signOut().then((value) => print("Sessión cerrada"));
    googleSignIn.signOut();
    print("Sesiones cerradas");
  }
}