import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/profile_cryptocurrency.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';


class ProfileCryptocurrenciesList extends StatefulWidget {
  
  @override
  State<ProfileCryptocurrenciesList> createState() => _ProfileCryptocurrenciesListState();
}

class _ProfileCryptocurrenciesListState extends State<ProfileCryptocurrenciesList> {
  UserBloc userBloc;

  Cryptocurrency cryptocurrency = Cryptocurrency(
      name: "Bitcoin",
      sharesCount: "30",
      moneyInvested: "1,814,640",
      price: "60488.0061",
      purchaseDate: "",
      status: "",
  );

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    Container buildItem(DocumentSnapshot doc, UserBloc bloc) {

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        height: 300,
        child: ListView(
          padding: EdgeInsets.all(10.0),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Center(
              child: Container(
                width: 260,
                child: Card(
                    child: Wrap(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Text(doc.data().toString()),
                        ListTile(

                        )
                      ],
                    )
                ),
              ),
            )
          ],
        ),
      );

    }

    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        left: 20.0,
        right: 20.0,
        bottom: 10.0
      ),
      child: StreamBuilder<QuerySnapshot >(
        stream: userBloc.cryptoStream,
        builder: (context, AsyncSnapshot<QuerySnapshot > snapshot){
          if(snapshot.hasData){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
                print("SNAPSHOT  "+snapshot.data.docs[0].toString());

                return Column(children: snapshot.data.docs.map((doc) => buildItem(doc, userBloc)).toList());
            }
          }else{
            return CircularProgressIndicator();
          }
        },
      )
    );

  }
}