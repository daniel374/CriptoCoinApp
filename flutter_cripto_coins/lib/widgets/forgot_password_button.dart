import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/repository/firebase_auth_api.dart';
import 'package:flutter_cripto_coins/User/ui/screens/forgot_password.dart';
import 'package:flutter_cripto_coins/User/ui/screens/register_screen.dart';


class ForgotPasswordButton extends StatelessWidget {

  final FirebaseAuthAPI _firebaseAuthAPI;

  ForgotPasswordButton({
    Key key, @required FirebaseAuthAPI firebaseAuthAPI
}):assert(firebaseAuthAPI!=null),
  _firebaseAuthAPI = firebaseAuthAPI,
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ForgotPassword()));
        },
        child: Text('Olvido Contraseña'));
  }
}