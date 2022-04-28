import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/title_header.dart';

class ProfileCryptocurrenciesList extends StatefulWidget {

  @override
  State<ProfileCryptocurrenciesList> createState() => _ProfileCryptocurrenciesListState();
}

class _ProfileCryptocurrenciesListState extends State<ProfileCryptocurrenciesList> {

  List dataCotizaciones;
  var currentUserId = FirebaseAuth.instance.currentUser.uid.toString();
  var cryptoQuotes = false;


  @override
  Widget build(BuildContext context) {

    Stream cryptocurrenciesStream = FirebaseFirestore.instance.collection("cryptocurrencies").snapshots();

    Container buildItem(DocumentSnapshot doc, context) {
      var userOwner = doc.get('userOwner').toString().split('DocumentReference<Map<String, dynamic>>(');
      //var currentUserId = FirebaseAuth.instance.currentUser.uid.toString();
      if(userOwner[1] == 'users/'+currentUserId+')'){

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          height: 100,
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

      } else {

        if(!cryptoQuotes){

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            height: 75,
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
                                                  title: "Actualmente Sin cotizaciones",
                                                  fontSize: 14.0,
                                                  colorTitle: Colors.black,
                                                ),
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

        }else {

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            height: 0,
            child: ListView(
              padding: EdgeInsets.all(10.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 0,
                    child: Card(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Stack(
                                children: [
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


      }


    }

    return Center(
      child: Container(
      margin: EdgeInsets.all(20.0),
      child: StreamBuilder<QuerySnapshot >(
        stream: cryptocurrenciesStream,
        //future: CloudFirestoreAPI().getCryptoCurrency(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var itemCount = snapshot.data.docs.length;
            var cryptocurrenciesUser = snapshot.data.docs.map((e) {
              print("e.data()  :");
              print(e.data());
              var cryptoData = e.get('userOwner').toString();
              var userOwner = cryptoData.split('DocumentReference<Map<String, dynamic>>(');

              if(userOwner[1].toString() == 'users/'+currentUserId+')'){
                cryptoQuotes = true;
                return buildItem(e, context);
              }else{
                return buildItem(e, context);
              }
            }
            );
            final Map mapFilterCrypto = {};

            switch(snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
                //print(snapshot.data.docs.toList());
                /*cryptocurrenciesUser.forEach((element) {
                  print("elemento   :");
                  print(element);
                });*/

                if(snapshot.hasData){

                  var userOwner = snapshot.data.docs.map((e) => ('userOwner').toString().split('DocumentReference<Map<String, dynamic>>('));
                  var currentUserId = FirebaseAuth.instance.currentUser.uid.toString();
                  /*if(userOwner. == 'users/'+currentUserId+')'){

                  }*/

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: cryptocurrenciesUser.toList()//snapshot.data.docs.map((doc) => buildItem(doc, userBloc)).toList()
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