import 'package:flutter/material.dart';

class GradientBackSignIn extends StatelessWidget {


  String title = "Popular";
  double height = 0.0;

  GradientBackSignIn(this.title, this.height);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/icon/ic_launcher.png"),
          //fit: BoxFit.cover,
          scale: 1,
          alignment: AlignmentDirectional(0.0, -0.7)
        ),
        gradient: LinearGradient(
            colors: [
              Color(0xFF3D285D),
              Color(0xFF282E5D)
            ],
          begin: FractionalOffset(0.2, 0.0),
          end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 0.6],
            tileMode: TileMode.clamp
        )
      ),


      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold
        ),
      ),

      alignment: Alignment(-0.9, -0.6),

    );
  }

}