import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';


class NewsMoneyTrading extends StatefulWidget {


  @override
  State createState() {
    return _NewsMoneyTrading();
  }
}


class _NewsMoneyTrading extends State<NewsMoneyTrading>{


  @override
  Widget build(BuildContext context) {
    return menuOperations();
  }

  Widget menuOperations(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
      ),
      body: Stack(
        //alignment: Alignment.center,
        children: [
          GradientBack(height: null,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Noticias")
          ),

        ],
      ),
    );

  }

}