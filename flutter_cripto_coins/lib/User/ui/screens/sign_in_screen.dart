import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/button_white.dart';
import 'package:flutter_cripto_coins/widgets/button_green.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back_sign_in.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cripto_coins/show_money_trading_cupertino.dart';

import '../../../show_money_trading_cupertino.dart';

class SignInScreen extends StatefulWidget {

  @override
  State createState() {
    return _SignUnScreen();
  }
}

class _SignUnScreen extends State<SignInScreen> {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext contest, AsyncSnapshot snapshot) {
        //snapshot - data - Objecr User
        if(!snapshot.hasData || snapshot.hasError){
          return signInGoogleUI();
        } else {
          return ShowMoneyTradingCupertino();
        }
      }
    );
  }

  Widget signInGoogleUI(){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBackSignIn("", null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("",
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
              ButtonGreen(
                text: "Login con Gmail",
                onPressed: () {
                  userBloc.signIn().then((user) => print("El user es: ${user.displayName}"));
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