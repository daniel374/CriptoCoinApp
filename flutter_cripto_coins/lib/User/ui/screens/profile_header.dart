import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/button_bar_profile.dart';

class ProfileHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final title = Text(
      'Profile',
      style: TextStyle(
        fontFamily: 'Lato',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30.0
      ),
    );

    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 50.0
      ),
      child: Column(
        children: [
          Row(
            children: [
              title,
            ],
          ),
          //UserInfo(),
          ButtonBarProfile()
        ],
      ),
    );

  }
}