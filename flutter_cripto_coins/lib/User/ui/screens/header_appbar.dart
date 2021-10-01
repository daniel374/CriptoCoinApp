import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/drawer_menu_lateral.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: DrawerMenuLateral(),
      body: Stack(
      //alignment: Alignment.center,
      children: [
        GradientBack("Bienvenido",250.0 ),
      ],
    ),
    );
  }

}