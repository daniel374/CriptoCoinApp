import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _showEye = false;
  bool _passwordEncrypted = true;

  String _password = '';

  @override
  Widget build(BuildContext context) {
    final _controllerPassword = TextEditingController();

    return Container(
      child: TextField(
        obscureText: _showEye ? _passwordEncrypted : true,
        onChanged: (enteredPassword) {
          _password = enteredPassword;
          if (enteredPassword.isEmpty) {
            setState(() {
              _showEye = false;
            });
          } else {
            if (!_showEye) {
              setState(() {
                _showEye = !_showEye;
              });
            }
          }
        },
        //controller: _controllerPassword,
        keyboardType: TextInputType.visiblePassword,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 15.0,
            fontFamily: "Lato",
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon:
                _showEye ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: tooglePasswordVisibility,
          ),
          filled: true,
          fillColor: Color(0xFFe5e5e5),
          border: InputBorder.none,
          hintText: "Contraseña",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFe5e5e5)),
              borderRadius: BorderRadius.all(Radius.circular(9.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFe5e5e5)),
              borderRadius: BorderRadius.all(Radius.circular(9.0))),
        ),
      ),
    );
  }

  void tooglePasswordVisibility() => setState(() => _showEye = !_showEye);
}