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
  Future<User> signIn() {
    return _auth_repository.signInFirebase();
  }

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}