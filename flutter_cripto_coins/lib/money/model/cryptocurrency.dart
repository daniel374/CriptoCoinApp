import 'package:flutter/material.dart';


class Cryptocurrency {

  String id;
  String name;
  String slug;
  String sharesCount;
  String moneyInvested;
  String price;
  String purchaseDate;
  String percentChangeOneH;
  String status;
  //UserStore userOwner;

  Cryptocurrency({
    Key key,
    @required this.id,
    @required this.name,
    @required this.slug,
    @required this.sharesCount,
    @required this.moneyInvested,
    @required this.price,
    @required this.purchaseDate,
    @required this.percentChangeOneH,
    @required this.status,
    //this.userOwner,
  });


}