import 'package:flutter/material.dart';


class MyTextButton extends StatefulWidget {

  final Color colorsTextNeutro;
  final Color colorsTextBold;
  final double fontSize;
  final String textNeutro;
  final String textBold;
  final Function onpressed;

  MyTextButton({
    @required this.colorsTextNeutro,
    @required this.colorsTextBold,
    @required this.fontSize,
    @required this.textNeutro,
    @required this.textBold,
    @required this.onpressed,
  });

  @override
  State createState() {
    return _MyTextButton();
  }
}


class _MyTextButton extends State<MyTextButton> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      child: TextButton(
        style: TextButton.styleFrom(
          //padding: EdgeInsets.all(16.0),
          primary: widget.colorsTextNeutro,
          textStyle: TextStyle(
            fontSize: widget.fontSize,
            fontFamily: "Lato",
          ),
        ),
        onPressed: widget.onpressed,
        child: RichText(
            text: new TextSpan(
                style: new TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.colorsTextNeutro,
                ),
                children: [
              new TextSpan(text: widget.textNeutro),
              new TextSpan(
                  text: widget.textBold,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.colorsTextBold,
                  )),
            ]
            )
        ),
      ),
    );
  }
}