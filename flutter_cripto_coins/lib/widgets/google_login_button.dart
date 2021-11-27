import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class GoogleLoginButton extends StatelessWidget {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {

    //const padding = 25.0;
    userBloc = BlocProvider.of(context);

    return Container(
      width: 250,
      padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      child: Column(
        children: [
          GoogleSignInButton(
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
            borderRadius: 10.0,
            darkMode: true,
            text: 'Ingresar con Google',
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.white,
            ),
            splashColor: Colors.white,
          ),
        ],
      ),
    );
  }
}