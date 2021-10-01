import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {

  String imgProfile;
  String name;
  String email;

  UserInfo(this.imgProfile, this.name, this.email);

  @override
  Widget build(BuildContext context) {

    final userPhoto = Container(
      width: 90.0,
      height: 90.0,
      margin: EdgeInsets.only(
        right: 20.0
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2.0,
          style: BorderStyle.solid
        ),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imgProfile)
        )
      ),
    );


  }
}