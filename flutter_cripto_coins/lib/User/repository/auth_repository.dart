import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cripto_coins/User/repository/firebase_auth_api.dart';

class AuthRepositoryAPI {

  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future signInFirebase() => _firebaseAuthAPI.signIn();

  signOut() => _firebaseAuthAPI.signOut();

}