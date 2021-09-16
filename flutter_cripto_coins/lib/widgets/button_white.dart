import 'package:flutter/material.dart';

class ButtonWhite extends StatefulWidget {

  final String text;
  double width = 0.0;
  double height = 0.0;
  final VoidCallback onPressed;

  ButtonWhite({Key key, @required this.text, @required this.onPressed, this.height, this.width});

  @override
  State createState() {
    return _ButtonWhite();
  }
}

class _ButtonWhite extends State<ButtonWhite> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20.0
        ),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: [
                  Color(0xFFa7ff84),//arriba
                  Color(0XFF1cbb78)//abajo
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0,0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp
            )
        ),

        child: Center(
          child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Lato",
                  color:Colors.white
              )
          ),
        ),
      ),
    );
  }
}