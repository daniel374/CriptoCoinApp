import 'package:flutter/material.dart';


class TitleHeader extends StatelessWidget {

  final String title;
  final double fontSize;
  final Color colorTitle;

  TitleHeader({
    Key key, @required this.title, @required this.fontSize, @required this.colorTitle
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Text(
      title,
      style: TextStyle(
        color: colorTitle,
        fontSize: fontSize,
        fontFamily: "Lato",
        fontWeight: FontWeight.bold,
      ),
    );
  }
}