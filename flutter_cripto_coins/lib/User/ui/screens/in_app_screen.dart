import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/ui/screens/register_screen.dart';
import 'package:flutter_cripto_coins/widgets/button_white.dart';
import 'package:flutter_cripto_coins/widgets/button_green.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back_sign_in.dart';
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
              Flexible(
                  child: Container(
                width: screenWidth,
                child: Text(
                  "",
                  style: TextStyle(
                      fontSize: 37.0,
                      fontFamily: "Lato",
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
              Padding(padding: EdgeInsets.all(56.0)),
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
                width: 300.0,
                height: 50.0,
              ),
              ButtonWhite(
                text: "Crear Cuenta",
                onPressed: () {
                  userBloc.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                width: 300.0,
                height: 50.0,
              ),
              ButtonGreen(
                text: "Login con Gmail",
                onPressed: () {
                  userBloc.signOut();
                  userBloc.signInGoogle().then((User user) {
                    userBloc.updateUserData(UserStore(
                      uid: user.uid,
                      name: user.displayName,
                      email: user.email,
                      photoURL: user.photoURL,
                    ));
                  });
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