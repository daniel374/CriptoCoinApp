import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/drawer_menu_lateral.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter_cripto_coins/widgets/title_header.dart';

class HeaderAppBar extends StatelessWidget {

  final String titleHeader;
  final double sizeHeader;

  HeaderAppBar({Key key, @required this.titleHeader, @required this.sizeHeader});

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
          GradientBack(
            height: 250.0,
          ),
          ListView(
            padding: EdgeInsets.only(top: 100.0),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleHeader(
                    title: titleHeader,
                    fontSize: sizeHeader,
                    colorTitle: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
