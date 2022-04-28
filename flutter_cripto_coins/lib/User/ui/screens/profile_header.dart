import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/user_info_coin.dart';
import 'package:flutter_cripto_coins/widgets/title_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileHeader extends StatefulWidget {

  final String titleHeader;
  final double sizeHeader;

  ProfileHeader({Key key, @required this.titleHeader, @required this.sizeHeader});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  UserBloc userBloc;

  UserStore user;

  Object title;

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of<UserBloc>(context);

    title = TitleHeader(
      title: widget.titleHeader,
      fontSize: widget.sizeHeader,
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

      user = UserStore(name: snapshot.data.displayName, lastname: '', email: snapshot.data.email, photoURL: snapshot.data.photoURL, uid: snapshot.data.uid);


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
                title: "Show Money Trading",
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