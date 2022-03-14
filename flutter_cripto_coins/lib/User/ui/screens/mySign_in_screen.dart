import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/repository/firebase_auth_api.dart';
import 'package:flutter_cripto_coins/widgets/button_white.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter_cripto_coins/widgets/mytext_form_field.dart';
import 'package:flutter_cripto_coins/widgets/title_header.dart';


class MySignInScreen extends StatefulWidget {

  const MySignInScreen({Key key}) : super(key: key);

  @override
  State createState() {
    return _MySignInScreen();
  }
}


class _MySignInScreen extends State<MySignInScreen> {
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  final FirebaseAuthAPI firebaseAuthAPI = FirebaseAuthAPI();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  UserStore _user;
  String _email, _password, e;

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
      if(_password.length < 8){
        toast("Contraseña minimo con 8 caracteres");
        return false;
      }
      return true;
    } else {
      return false;
    }
  }


  /*Widget showAlert() {
    if (e != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: TitleHeader(
                title: e,
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    e = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }*/


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
              //showAlert(),
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
                      MyTextFormField(
                        obscureText: _isObscure,
                        maxLines: 1,
                        controller: _controllerPassword,
                        validator: PasswordValidator.validate,
                        onsave: (newValue) {
                          _password = newValue;
                        },
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: _isObscure
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: tooglePasswordVisibility,
                        ),
                        hintText: 'Contraseña',
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "¿Olvido la contraseña?",
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline
                              ),)
                          ],
                        ),
                      ),
                      ButtonWhite(
                        text: "Login",
                        onPressed: () {
                          if (validateForm()) {
                            loginUser();
                          }
                        },
                        width: 150.0,
                        height: 50.0,
                      ),
                    ],
                  ))
            ],
          )
        ],
      ),
    );

  }

  void tooglePasswordVisibility() => setState(() => _isObscure = !_isObscure);

  void loginUser() async {
    dynamic result = await firebaseAuthAPI.signIn(_controllerEmail.text, _controllerPassword.text);
    if (result == null) {
      print('Email ó correo incorrectos');
    } else {
      print(result.toString());
      _controllerPassword.clear();
      _controllerEmail.clear();
      Navigator.pop(context);
    }
  }

}