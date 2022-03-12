import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/ui/screens/profile_header.dart';
import 'package:flutter_cripto_coins/money/ui/screens/home_money_trading.dart';
import 'package:flutter_cripto_coins/money/ui/screens/menu_money_home/history_operations.dart';
import 'package:flutter_cripto_coins/money/ui/screens/menu_money_home/menu_operations.dart';
import 'package:flutter_cripto_coins/money/ui/screens/menu_money_home/news_money_trading.dart';
import 'package:flutter_cripto_coins/money/ui/screens/menu_money_home/show_crypto_moneys.dart';


class DrawerMenuLateral extends StatelessWidget {



  Widget buildMenuItem({
    @required Text text,
    @required IconData icon,
    VoidCallback onClicked,
  }){

    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color,),
      title: text,
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeMoneyTrading(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShowCryptoMoneys(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MenuOperations(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HistoryOperations(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewsMoneyTrading(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeMoneyTrading(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeMoneyTrading(),
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: [
            ProfileHeader(
              titleHeader: 'Menú',
              sizeHeader: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 16,),
                  buildMenuItem(
                    text: Text("Cotizaciones", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),),
                    icon: Icons.request_quote_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16,),
                  buildMenuItem(
                    text: Text("Crypto monedas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),),
                    icon: Icons.money,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16,),
                  buildMenuItem(
                    text: Text("Operaciones", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),),
                    icon: Icons.app_registration_sharp,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16,),
                  buildMenuItem(
                    text: Text("Historial", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),),
                    icon: Icons.app_registration_sharp,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 16,),
                  buildMenuItem(
                    text: Text("Noticias", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),),
                    icon: Icons.open_in_new_outlined,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16,),
                  buildMenuItem(
                    text: Text("Ajustes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),),
                    icon: Icons.app_settings_alt_rounded,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 16,),
                  buildMenuItem(
                    text: Text("Acerca del programa", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),),
                    icon: Icons.info,
                    onClicked: () => selectedItem(context, 6),
                  ),

                ],
              ),

            )

          ],
        )

      ),
    );

  }
}