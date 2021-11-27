import 'package:flutter/material.dart';


class TitleHeader extends StatelessWidget {

  final String title;
  double fontSize = 30.0;

  TitleHeader({
    Key key, @required this.title, this.fontSize
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontFamily: "Lato",
        fontWeight: FontWeight.bold,
      ),
    );
  }
}