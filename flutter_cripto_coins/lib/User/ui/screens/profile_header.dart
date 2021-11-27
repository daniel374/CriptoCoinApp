import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/button_bar_profile.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/user_info.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileHeader extends StatelessWidget {

  UserBloc userBloc;
  UserStore user;

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
        stream: userBloc.streamFirebase,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.none:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return showProfileData(snapshot);
            case ConnectionState.done:
              return showProfileData(snapshot);
          }
        }
    );

  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if(!snapshot.hasData || snapshot.hasError) {
      print("No logueado");
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
                CircularProgressIndicator(),
                Text("No se pudo cargar la información. Haz login.")
              ],
            ),
            //UserInfo(),
            ButtonBarProfile()
          ],
        ),
      );
    } else {
      print("Logueado");
      print(snapshot.data);
      user = UserStore(name: snapshot.data.displayName, email: snapshot.data.email, photoURL: snapshot.data.photoURL);
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
            UserInfo(user),
            ButtonBarProfile()
          ],
        ),
      );

    }
  }

}