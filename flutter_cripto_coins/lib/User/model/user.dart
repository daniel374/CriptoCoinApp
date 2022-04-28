import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';

class UserStore extends Equatable{
  String uid;
  String name;
  String lastname;
  String email;
  String password;
  String country;
  String phoneOne;
  String phoneTwo;
  String investment;
  String gain;
  String photoURL;
  List<Cryptocurrency> cryptoStocks;

  //myFavoritePlaces
  //myPlaces
  UserStore({
    Key key,
    @required this.uid,
    this.name,
    this.lastname,
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

  //static var empty = UserStore(email: '', uid: '');

  @override
  List<Object> get props => [email, uid, name, country, phoneOne, phoneTwo, cryptoStocks];
}