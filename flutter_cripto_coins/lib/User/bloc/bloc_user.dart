import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/repository/auth_repository.dart';
import 'package:flutter_cripto_coins/User/repository/cloud_firestore_api.dart';
import 'package:flutter_cripto_coins/User/repository/cloud_firestore_repository.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/profile_cryptocurrency.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';

class UserBloc implements Bloc {
  AuthRepositoryAPI _auth_repository = AuthRepositoryAPI();

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

  Future<User> signIn() => _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos:
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  void updateUserData(UserStore user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  //3. actualiza data de cryptomonedas del usuario
  Future<void> updateCryptocurrencyData(Cryptocurrency cryptocurrency) =>
      _cloudFirestoreRepository.updateCryptocurrencyData(cryptocurrency);

  //eSCUCHA cuando la data cambie
  Stream<QuerySnapshot> cryptoListStream = FirebaseFirestore.instance.collection(CloudFirestoreAPI().CRYPTOCURRENCIES).snapshots();
  Stream<QuerySnapshot> get cryptoStream => cryptoListStream;

  List<ProfileCryptocurrency> buildCruptocurrencies(
          List<DocumentSnapshot> cryptourrenciesListSnapshot) =>
      _cloudFirestoreRepository
          .buildCruptocurrencies(cryptourrenciesListSnapshot);

  Future<User> signUp() {
    return _auth_repository.signUpFirebase();
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
