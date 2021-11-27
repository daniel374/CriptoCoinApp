import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/ui/screens/register_screen.dart';
import 'package:flutter_cripto_coins/widgets/button_white.dart';
import 'package:flutter_cripto_coins/widgets/button_green.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/widgets/google_login_button.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back_sign_in.dart';
import 'package:flutter_cripto_coins/widgets/my_text_button.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_cripto_coins/show_money_trading_cupertino.dart';

import '../../../show_money_trading_cupertino.dart';
import 'mySign_in_screen.dart';

class InAppScreen extends StatefulWidget {

  @override
  State createState() {
    return _InAppScreen();
  }
}

class _InAppScreen extends State<InAppScreen> {

  UserBloc userBloc;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    screenWidth = MediaQuery.of(context).size.width;

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

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBack(
            height: null,
          ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset(
                      'images/icon/ic_launcher.png',
                      height: 200,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20.0)),
                  ButtonWhite(
                    text: "Login",
                    onPressed: () {
                      userBloc.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MySignInScreen()),
                      );
                    },
                    width: 220.0,
                    height: 40.0,
                  ),
                  GoogleLoginButton(),
                  MyTextButton(
                    textNeutro: '¿No tienes una cuenta? ',
                    textBold: 'Registrate',
                    fontSize: 14.0,
                    colorsTextNeutro: Colors.white,
                    colorsTextBold: Colors.blue,
                    onpressed: () {
                      userBloc.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                  ),

                ],
              )
            ],
          ),

    );
  }
}