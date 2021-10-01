import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/ui/screens/header_appbar.dart';
import 'package:flutter_cripto_coins/User/ui/screens/profile_header.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/profile_background.dart';

class ProfileMoneyTrading extends StatelessWidget {

  String descriptionDummy = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been "
      "the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
      "\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
      "when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        ProfileBackground(),
        ListView(
          children: [
            ProfileHeader(),

          ],
        ),
        //HeaderAppBar()
      ],
    );
  }
}