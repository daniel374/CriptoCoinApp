import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/repository/cloud_firestore_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'cloud_firestore_api.dart';

class SignUpFailure implements Exception {}

class FirebaseAuthAPI {
  FirebaseAuth fbAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  // Constructor
  FirebaseAuthAPI({FirebaseAuth fbAuth, GoogleSignIn googleSignIn})
      : fbAuth = fbAuth ?? FirebaseAuth.instance,
        googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<User> signInGoogle({BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    if (googleSignInAccount != null) {
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gSA.accessToken,
        idToken: gSA.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            FirebaseAuthAPI.customSnackBar(
              content:
                  'The account already exists with a different credential.',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            FirebaseAuthAPI.customSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          FirebaseAuthAPI.customSnackBar(
            content: 'Error occurred using Google Sign-In. Try again.',
          ),
        );
      }
    }

    return user;
  }

  // Sign Up with email and password
  Future<User> signUp(String name, String lastName, String phoneOne,
      String country, String email, String password) async {
    try {
      var auth = await fbAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await CloudFirestoreAPI().updateUserData(UserStore(
          name: name,
          lastname: lastName,
          phoneOne: phoneOne,
          country: country,
          password: password,
          email: auth.user.email,
          uid: auth.user.uid));
      await auth.user.updateDisplayName(name);
      await auth.user.reload();


      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign In with email and password
  Future<User> signIn(String email, String password) async {
    try {
      var auth = await fbAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign Out
  Future<void> signOut() async {
    return Future.wait([ fbAuth.signOut().then((value) => print("Sessión cerrada")),
    googleSignIn.signOut().then((value) => print("Sesiones cerradas")),
    ]);
  }

  // check Sign In
  Future<void> isSignedIn() async {
    var currentUser = await fbAuth.currentUser;
    return currentUser != null;
  }

  // get current user
  Future<void> getCurrentUser() async {
    return await fbAuth.currentUser;
  }

  static SnackBar customSnackBar({String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}