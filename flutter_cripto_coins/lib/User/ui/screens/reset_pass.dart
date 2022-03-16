import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/button_white.dart';
import '../../../widgets/gradient_back.dart';
import '../../../widgets/mytext_form_field.dart';
import '../../../widgets/title_header.dart';
import '../../repository/firebase_auth_api.dart';

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

  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey,
      gravity: ToastGravity.BOTTOM,
    );
  }

  bool validateForm() {
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      RegExp regExp = new RegExp(
          r'^([a-zA-Z0-9_\-.]+)@([a-zA-Z0-9_\-.]+)\.([a-zA-Z]{2,5})$'
      );
      if(!regExp.hasMatch(_email)){
        //toast
        toast("Ingresa un email válido");
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
                      TitleHeader(title: "Cripto Coins App", fontSize: 35.0,),

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

  _resetPasword(){

  }

}