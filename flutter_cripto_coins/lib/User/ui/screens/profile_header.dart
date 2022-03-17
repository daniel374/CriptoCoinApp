import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/user_info_coin.dart';
import 'package:flutter_cripto_coins/widgets/title_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileHeader extends StatelessWidget {

  UserBloc userBloc;
  UserStore user;
  final String titleHeader;
  final double sizeHeader;
  Object title;

  ProfileHeader({Key key, @required this.titleHeader, @required this.sizeHeader});

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of<UserBloc>(context);

    title = TitleHeader(
      title: titleHeader,
      fontSize: sizeHeader,
      colorTitle: Colors.white,
    );

    return showStreamData();

  }

  showStreamData() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if((snapshot.connectionState == ConnectionState.waiting) || snapshot.connectionState == ConnectionState.none){
            return waitProfileDate();
          }else{
            return showProfileData(snapshot);
          }
        }
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if(!snapshot.hasData || snapshot.hasError) {
      //print("No logueado");
      return waitProfileDate();
    } else {
      /*print("Logueado");
      print(snapshot.data);*/
      user = UserStore(name: snapshot.data.displayName, lastname: '', email: snapshot.data.email, photoURL: snapshot.data.photoURL, uid: '');

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
            UserInfoCoin(user),
          ],
        ),
      );

    }
  }

  Widget waitProfileDate() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
      child: Column(
        children: [
          Row(
            children: [
              title,
            ],
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(top: 50.0)),
              CircularProgressIndicator(),
              TitleHeader(
                title: "    Cripto Coins App",
                fontSize: 20.0,
                colorTitle: Colors.white,
              ),
            ],
          )

        ],
      ),
    );
  }
}