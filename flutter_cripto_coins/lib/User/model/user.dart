import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';

class UserStore extends Equatable{
  final String uid;
  final String name;
  final String lastname;
  final String email;
  final String password;
  final String country;
  final String phoneOne;
  final String phoneTwo;
  final String investment;
  final String gain;
  final String photoURL;
  final List<Cryptocurrency> cryptoStocks;

  //myFavoritePlaces
  //myPlaces
  const UserStore({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.lastname,
    @required this.email,
    this.password,
    this.country,
    this.phoneOne,
    this.phoneTwo,
    this.investment,
    this.gain,
    this.photoURL,
    this.cryptoStocks
  });

  static const empty = UserStore(email: '', uid: '');

  @override
  List<Object> get props => [email, uid, name, country, phoneOne, phoneTwo, cryptoStocks];
}