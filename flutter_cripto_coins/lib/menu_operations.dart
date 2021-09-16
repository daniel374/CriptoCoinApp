import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';

class MenuOperations extends StatefulWidget {

  @override
  State createState() {
    return _MenuOperations();
  }

}

class _MenuOperations extends State<MenuOperations>{


  @override
  Widget build(BuildContext context) {
    return menuOperations();
  }

  Widget menuOperations(){
    return Scaffold(
        appBar: AppBar(
          title: Text('Operaciones'),
        ),
        body: Stack(
        //alignment: Alignment.center,
        children: [
        GradientBack("", null),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new DropdownButton<String>(
            items: <String>['Equilibrar', 'Equidad', 'Margen libre', 'Nivel de margen(%)', 'Margen'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          ),
        )
        ],
        ),
    );

  }

}