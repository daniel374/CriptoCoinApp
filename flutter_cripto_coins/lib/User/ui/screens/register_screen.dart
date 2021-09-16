import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/button_white.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter/src/material/text_form_field.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State createState() {
    return _RegisterScreen();
  }
}

class _RegisterScreen extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    //final Responsive responsive = Responsive.of(context);
    return registerUI();
  }

  Widget registerUI() {
     return Scaffold(
       body: Stack(
         alignment: Alignment.center,
         children: [
           GradientBack("", null),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("Registro \n",
                 style: TextStyle(
                     fontSize: 27.0,
                     fontFamily: "Lato",
                     color: Colors.white,
                     fontWeight: FontWeight.bold
                 ),
               ),
               Text("Cripto Coins App",
                 style: TextStyle(
                     fontSize: 37.0,
                     fontFamily: "Lato",
                     color: Colors.white,
                     fontWeight: FontWeight.bold
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                   decoration: const InputDecoration(
                     icon: Icon(Icons.person),
                     hintText: 'Correo electronico',
                     labelText: 'Email *',
                   ),
                   onSaved: (String value) {
                     // This optional block of code can be used to run
                     // code when the user saves the form.
                   },
                   validator: (String value) {
                     return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                   },
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                   decoration: const InputDecoration(
                     icon: Icon(Icons.email_outlined),
                     hintText: '¿Cual es su nombre?',
                     labelText: 'Nombre *',
                   ),
                   onSaved: (String value) {
                     // This optional block of code can be used to run
                     // code when the user saves the form.
                   },
                   validator: (String value) {
                     return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                   },
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                   decoration: const InputDecoration(
                     icon: Icon(Icons.vpn_key_outlined),
                     hintText: 'Contraseña *',
                     labelText: 'Clave',
                   ),
                   onSaved: (String value) {
                     // This optional block of code can be used to run
                     // code when the user saves the form.
                   },
                   validator: (String value) {
                     return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                   },
                 ),
               ),
               ButtonWhite(text: "Crear Cuenta", onPressed: (){

               },
                 width: 300.0,
                 height: 50.0,
               ),

             ],
           )
         ],
       ),
     );

  }
}