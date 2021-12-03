import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/ui/screens/profile_header.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/button_bar_profile.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/profile_background.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/profile_cryptocurrencies_list.dart';

class ProfileMoneyTrading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        ProfileBackground(),
        ListView(
          children: [
            ProfileHeader(
              titleHeader: 'Perfil',
              sizeHeader: 30.0,
            ),
            ButtonBarProfile(),
            ProfileCryptocurrenciesList(),
          ],
        ),
        //HeaderAppBar()
      ],
    );
  }
}