import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/button_white.dart';
import '../../../widgets/gradient_back.dart';
import '../../../widgets/mytext_form_field.dart';
import '../../../widgets/title_header.dart';
import 'package:flutter_cripto_coins/User/repository/firebase_auth_api.dart';

import 'mySign_in_screen.dart';

class ChangePass extends StatefulWidget {

  @override
  State createState() {
    return _ChangePassState();
  }
}

class _ChangePassState extends State<ChangePass> {

  final FirebaseAuthAPI firebaseAuthAPI = FirebaseAuthAPI();

  final _newPasswordController = TextEditingController();
  final _newConfirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  String _newPass, _confirNewPass;

  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey,
      gravity: ToastGravity.BOTTOM,
    );
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
                        obscureText: _isObscure,
                        maxLines: 1,
                        controller: _newPasswordController,
                        validator: PasswordValidator.validate,
                        onsave: (newValue) {
                          _newPass = newValue;
                        },
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: _isObscure
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: tooglePasswordVisibility,
                        ),
                        hintText: 'Nueva contraseña',
                      ),

                      MyTextFormField(
                        obscureText: _isObscure,
                        maxLines: 1,
                        controller: _newConfirmPasswordController,
                        validator: PasswordValidator.validate,
                        onsave: (newValue) {
                          _confirNewPass = newValue;
                        },
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: _isObscure
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: tooglePasswordVisibility,
                        ),
                        hintText: 'Confirmar neva contraseña',
                      ),

                      ButtonWhite(
                        text: "Cambiar contraseña",
                        onPressed: () {
                          if (validateForm()) {
                            _changePasword();
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

  void tooglePasswordVisibility() => setState(() => _isObscure = !_isObscure);

  bool validateForm() {
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      if(_newPass.length < 8 || _confirNewPass.length < 8){
        toast("Contraseña minimo con 8 caracteres");
        return false;
      }
      if(_newPass != _confirNewPass){
        toast("Las contraseñas no coinciden");
        return false;
      }
      return true;
    } else {
      return false;
    }

  }

  _changePasword(){
    firebaseAuthAPI.changePassword(_newPass);
    _newPasswordController.clear();
    _newConfirmPasswordController.clear();
    Navigator.pop(context);
  }

}