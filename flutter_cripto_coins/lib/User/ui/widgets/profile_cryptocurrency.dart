import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/profile_cryptocurrency_info.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';


class ProfileCryptocurrency extends StatelessWidget {

  Cryptocurrency cryptocurrency;

  ProfileCryptocurrency(this.cryptocurrency);

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment(0.0, 0.8),
      children: [
        ProfileCryptocurrencyInfo(cryptocurrency),
      ],
    );

  }

}