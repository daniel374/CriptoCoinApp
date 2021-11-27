import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cripto_coins/User/repository/firebase_auth_api.dart';

class AuthRepositoryAPI {

  final _firebaseAuthAPI = FirebaseAuthAPI();
  String name;
  String lastName;
  String phoneOne;
  String country;
  String email;
  String password;

  Future signInFirebaseGoogle() => _firebaseAuthAPI.signInGoogle();

  Future signInFirebase() => _firebaseAuthAPI.signIn(email, password);

  Future signUpFirebase() => _firebaseAuthAPI.signUp(name, lastName, phoneOne, country, email, password);

  Future isSignedFirebase() => _firebaseAuthAPI.isSignedIn();

  Future getCurrentUserFirebase() => _firebaseAuthAPI.getCurrentUser();

  Future signOut() => _firebaseAuthAPI.signOut();

}