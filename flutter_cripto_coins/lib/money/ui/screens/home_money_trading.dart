import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/ui/screens/header_appbar.dart';
import 'package:flutter_cripto_coins/widgets/drawer_menu_lateral.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';

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
        HeaderAppBar()
      ],
    );

  }
}