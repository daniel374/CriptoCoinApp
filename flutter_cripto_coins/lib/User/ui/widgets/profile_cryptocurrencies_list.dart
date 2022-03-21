import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import '../../../widgets/title_header.dart';
import '../../repository/cloud_firestore_api.dart';


class ProfileCryptocurrenciesList extends StatefulWidget {
  
  @override
  State<ProfileCryptocurrenciesList> createState() => _ProfileCryptocurrenciesListState();
}

class _ProfileCryptocurrenciesListState extends State<ProfileCryptocurrenciesList> {
  UserBloc userBloc;

  List dataCotizaciones;


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
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: TitleHeader(
                                              title: doc.get("name").toString(),
                                              fontSize: 14.0,
                                              colorTitle: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text("Precio: "+doc.get("price").toString())
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text("estado: "+doc.get("status").toString())
                                          ),
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
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

    return Center(
      child: Container(
      margin: EdgeInsets.all(20.0),
      child: StreamBuilder<QuerySnapshot >(
        stream: FirebaseFirestore.instance.collection("cryptocurrencies").snapshots(),
        //future: CloudFirestoreAPI().getCryptoCurrency(),
        builder: (context, AsyncSnapshot<QuerySnapshot > snapshot){
          if(snapshot.hasData){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
                print(snapshot);
                if(snapshot.hasData){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data.docs.map((doc) => buildItem(doc, userBloc)).toList()
                  );
                }else{
                  return CircularProgressIndicator();
                }

            }
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    ),
    );

  }
}