import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/repository/cloud_firestore_api.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/profile_cryptocurrency.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';


class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(UserStore user) =>
      _cloudFirestoreAPI.updateUserData(user);

  Future<void> updateCryptocurrencyData(Cryptocurrency cryptocurrency) =>
      _cloudFirestoreAPI.updateCryptocurrencyData(cryptocurrency);

  List<ProfileCryptocurrency> buildCruptocurrencies(
          List<DocumentSnapshot> cryptourrenciesListSnapshot) =>
      _cloudFirestoreAPI.buildCruptocurrencies(cryptourrenciesListSnapshot);
}