import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/button_white.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter_cripto_coins/widgets/mytext_form_field.dart';
import 'package:flutter_cripto_coins/widgets/title_header.dart';
import 'package:flutter_cripto_coins/User/repository/firebase_auth_api.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({Key key}) : super(key: key);

  @override
  State createState() {
    return _RegisterScreen();
  }
}

class _RegisterScreen extends State<RegisterScreen> {
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerCountry = TextEditingController();
  final _controllerCellPhone = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerLastName = TextEditingController();

  final FirebaseAuthAPI firebaseAuthAPI = FirebaseAuthAPI();


  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    //final Responsive responsive = Responsive.of(context);

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
                        hintText: 'Nombre',
                        controller: _controllerName,
                        obscureText: false,
                        prefixIcon: Icon(Icons.person),
                      ),
                      MyTextFormField(
                        maxLines: 1,
                        hintText: 'Apellido',
                        controller: _controllerLastName,
                        obscureText: false,
                        prefixIcon: Icon(Icons.person),
                      ),
                      MyTextFormField(
                        maxLines: 1,
                        hintText: 'País',
                        controller: _controllerCountry,
                        obscureText: false,
                        prefixIcon: Icon(Icons.place),
                      ),
                      MyTextFormField(
                        maxLines: 1,
                        hintText: 'Teléfono',
                        controller: _controllerCellPhone,
                        obscureText: false,
                        prefixIcon: Icon(Icons.phone),
                      ),
                      MyTextFormField(
                        maxLines: 1,
                        controller: _controllerEmail,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email no puede estar vacío';
                          } else
                            return null;
                        },
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Correo Electrónico',
                        obscureText: false,
                      ),
                      MyTextFormField(
                        obscureText: _isObscure,
                        maxLines: 1,
                        controller: _controllerPassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'La contraseña no puede estar vacía';
                          } else
                            return null;
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
                      ButtonWhite(
                        text: "Registro",
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            createUser();
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

  void createUser() async {
    dynamic result = await firebaseAuthAPI.signUp(_controllerName.text,_controllerLastName.text,_controllerCellPhone.text,_controllerCountry.text,
        _controllerEmail.text, _controllerPassword.text);
    if (result == null) {
      print('Email invalido');
    } else {
      print(result.toString());
      _controllerPassword.clear();
      _controllerEmail.clear();
      Navigator.pop(context);
    }
  }
}