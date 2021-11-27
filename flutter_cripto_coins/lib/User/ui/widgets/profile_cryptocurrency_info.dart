import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';


class ProfileCryptocurrencyInfo extends StatelessWidget {


  Cryptocurrency cryptocurrency;

  ProfileCryptocurrencyInfo(this.cryptocurrency);


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final cryptocurrency = Text(
      this.cryptocurrency.name,
      style: TextStyle(
        fontFamily: 'Lato',
        fontSize: 20.0,
        fontWeight: FontWeight.bold
      ),
    );

    final placeInfo = Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.cryptocurrency.name,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              fontFamily: 'Lato',
              fontSize: 12.0,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            this.cryptocurrency.moneyInvested,
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                fontFamily: 'Lato',
                fontSize: 12.0,
                fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );

    final card = Container(
      width: screenWidth * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10.0,
            offset: Offset(0.0, 5.0)
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            placeInfo,
          ],
        ),
      ),
    );

    return Stack(
      alignment: Alignment(0.8, 1.25),
      children: [
        card,
      ],
    );

  }
}