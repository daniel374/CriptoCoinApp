import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/user_info.dart';
import 'package:flutter_cripto_coins/widgets/title_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileHeader extends StatelessWidget {

  UserBloc userBloc;
  UserStore user;
  final String titleHeader;
  final double sizeHeader;

  ProfileHeader({Key key, @required this.titleHeader, @required this.sizeHeader});

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
        stream: userBloc.streamFirebase,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              //return CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              return showProfileData(snapshot);
          }
        }
    );

  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if(!snapshot.hasData || snapshot.hasError) {
      //print("No logueado");
      return Container(
        height: 90.0,
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  Text("   cargando información...")
                ],
              ),
            )
          ],
        ),
      );
    } else {
      /*print("Logueado");
      print(snapshot.data);*/
      user = UserStore(name: snapshot.data.displayName, lastname: '', email: snapshot.data.email, photoURL: snapshot.data.photoURL, uid: '');
      final title = TitleHeader(
        title: titleHeader,
        fontSize: sizeHeader,
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
            UserInfo(user),
          ],
        ),
      );

    }
  }

}