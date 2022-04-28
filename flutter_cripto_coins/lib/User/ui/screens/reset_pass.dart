import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/button_white.dart';
import '../../../widgets/gradient_back.dart';
import '../../../widgets/mytext_form_field.dart';
import '../../../widgets/title_header.dart';
import '../../repository/firebase_auth_api.dart';
import 'mySign_in_screen.dart';

class ResetPasword extends StatefulWidget {

  @override
  State createState() {
    return _ResetPassword();
  }
}

class _ResetPassword extends State<ResetPasword> {

  final FirebaseAuthAPI firebaseAuthAPI = FirebaseAuthAPI();

  final _controllerEmail = TextEditingController();
  String _email;

  final _formKey = GlobalKey<FormState>();


  bool validateForm() {
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      RegExp regExp = new RegExp(
          r'^([a-zA-Z0-9_\-.]+)@([a-zA-Z0-9_\-.]+)\.([a-zA-Z]{2,5})$'
      );
      if(!regExp.hasMatch(_email)){
        //toast
        firebaseAuthAPI.toast("Ingresa un email válido");
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            GradientBack(
              height: null,
            ),
            ListView(
              padding: EdgeInsets.only(top: 100.0),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleHeader(title: "Show Money Trading", fontSize: 35.0, colorTitle: Color(0xFFFFFFFF)),

                      MyTextFormField(
                        maxLines: 1,
                        controller: _controllerEmail,
                        validator: EmailValidator.validate,
                        onsave: (newValue) {
                          _email = newValue;
                        },
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Correo Electrónico',
                        obscureText: false,
                      ),

                      ButtonWhite(
                        text: "Cambiar contraseña",
                        onPressed: () {
                          if (validateForm()) {
                            _resetPasword();
                          }
                        },
                        width: 250.0,
                        height: 50.0,
                      ),

                    ],
                  ),
                ),
              ],
            )
          ],
        )
    );
  }

  Future _resetPasword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.trim());

      FirebaseAuthAPI.customSnackBar(content: "¡Email enviado para resetear la contraseña!");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MySignInScreen()),
      );
    } catch(er){
      print(er.toString());
      firebaseAuthAPI.toast(er.message);
      Navigator.pop(context);
    }
  }

}