import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/button_white.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter_cripto_coins/widgets/button_green.dart';

class SignInScreen extends StatefulWidget {

  @override
  State createState() {
    return _SignUnScreen();
  }
}

class _SignUnScreen extends State<SignInScreen> {


  @override
  Widget build(BuildContext context) {
    return signInGoogleUI();
  }

  Widget signInGoogleUI(){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBack("", null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Bienvenido \n Cripto Coins App",
              style: TextStyle(
                fontSize: 37.0,
                fontFamily: "Lato",
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              ),
              ButtonWhite(text: "Crear Cuenta", onPressed: (){

              },
              width: 300.0,
              height: 50.0,
              ),
              ButtonGreen(text: "Login con Gmail", onPressed: () {

              },
                width: 300.0,
                height: 50.0,
              )
            ],
          )
        ],
      ),
    );
  }
}