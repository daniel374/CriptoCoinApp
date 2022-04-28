import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/ui/screens/header_appbar.dart';

class HomeMoneyTrading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        ListView(
          children: [
            Text("Home Show Money Trading")
          ],

        ),
        HeaderAppBar(
          titleHeader: "Bienvenido a Show Money Trading",
          sizeHeader: 35.0,
        )
      ],
    );

  }
}