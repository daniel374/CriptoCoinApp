import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_cripto_coins/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBloc implements Bloc {

  final _auth_repository = AuthRepositoryAPI();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;


  // Casos de use objeto User
  //1. SignIn a la App con Google.
  Future<User> signInGoogle() {
    return _auth_repository.signInFirebaseGoogle();
  }

  Future<User> signUp() {
    return _auth_repository.signUpFirebase();
  }

  Future<User> signIn() {
    return _auth_repository.signInFirebase();
  }

  Future signOut() {
    _auth_repository.signOut();
  }

  Future isSignedUser() {
    return _auth_repository.isSignedFirebase();
  }

  Future getCurrentUser() {
    return _auth_repository.getCurrentUserFirebase();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}