import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';

class UserInfoCoin extends StatefulWidget {

  UserStore userInfo;

  UserInfoCoin(@required this.userInfo);

  @override
  State<UserInfoCoin> createState() => _UserInfoCoinState();
}

class _UserInfoCoinState extends State<UserInfoCoin> {

  @override
  Widget build(BuildContext context) {

    final userPhoto = Container(
      width: 70.0,
      height: 70.0,
      margin: EdgeInsets.only(
        top: 0.0,
        right: 10.0
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
              //image: AssetImage(user.photoURL)
              image: (widget.userInfo.photoURL != null)
                  ? NetworkImage(widget.userInfo.photoURL)
                  : NetworkImage(
                  'https://clubdeescritura.com/wp-content/uploads/users-54/user-53932/2017/05/photo-300x300.png'),
          )
      ),
    );

    //print('nombre: ' + user.name + ' email: ' + user.email);
    final userInfo = Flexible(
        child: Container(
          margin: EdgeInsets.only(
              top: 10.0
          ),
          height: 130.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.0, bottom: 5.0),
                child: Text(
                  (widget.userInfo.name != null) ? widget.userInfo.name : '',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              Text(
                (widget.userInfo.email != null) ? widget.userInfo.email : '',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white30,
                  fontFamily: 'Lato',
                ),
              )
            ],
          ),
        )
    );

    return Container(
      child: Row(
        children: [
          userPhoto,
          userInfo
        ],
      ),
    );

  }
}