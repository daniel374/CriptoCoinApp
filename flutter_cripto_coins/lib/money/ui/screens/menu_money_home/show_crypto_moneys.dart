import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/ui/screens/add_cryptocurrency_user.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

import 'menu_operations.dart';


List<StaggeredTile> _staggeredTiles = <StaggeredTile>[];

class ShowCryptoMoneys extends StatefulWidget {

  @override
  State<ShowCryptoMoneys> createState() => _ShowCryptoMoneysState();
}

class _ShowCryptoMoneysState extends State<ShowCryptoMoneys> {

  Future<List<_ShowCryptoMoneys>> _listCryptoMOneys;

  Future<List<_ShowCryptoMoneys>> _getListCryptoMOneys() async {
    final response = await http.get(Uri.parse("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"),
        headers: {"X-CMC_PRO_API_KEY":"9dc108f9-84a3-404f-8fa1-9c18d13672d3"}
        );

    List<_ShowCryptoMoneys> showCrypto = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
      /*print(jsonData["data"][0]["name"]);*/
      for(var item in jsonData["data"]){
        showCrypto.add(
          _ShowCryptoMoneys(Colors.black,
              Icons.radio,
              item["name"],
              item["num_market_pairs"].toStringAsFixed(3),
              item["quote"]["USD"]["price"].toStringAsFixed(3),
              item["slug"],
              item["quote"]["USD"]["percent_change_1h"].toStringAsFixed(3),
              Colors.blue)
        );
        _staggeredTiles.add(
          StaggeredTile.count(4, 1)
        );
      }

      //print(showCrypto);
      return showCrypto;

    } else {
      throw Exception("Failed conection");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listCryptoMOneys = _getListCryptoMOneys();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Crypiomonedas'),
        ),
        body: FutureBuilder(
          future: _listCryptoMOneys,
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              //print(snapshot.data);
              return Stack(
                children: [
                  GradientBack(height: null,),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: StaggeredGridView.count(
                    crossAxisCount: 4,
                    staggeredTiles: _staggeredTiles,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    padding: const EdgeInsets.all(4),
                    children: _listCryptoMOneysData(snapshot.data),
                    )
                  ),
                ],
              );

            } else if (snapshot.hasError) {
              //print(snapshot.hasError);
              return Text("Error");
            }

            return Center(
            child: CircularProgressIndicator(),
            );
          },
        ),
    );
  }

  List<Widget> _listCryptoMOneysData(List<_ShowCryptoMoneys> data){
    List<Widget> moneys = [];

    for(var money in data){
      moneys.add(_CriptoMoneyCard(Colors.black, Icons.radio, money.cryptoMoney, money.numMarketPairs, money.hightValue, money.slug, money.percentChangeOneH, Colors.blue));
    }

    return moneys.toList();

  }
}

class _ShowCryptoMoneys {

  Color backgroundColor;
  IconData iconData;
  String cryptoMoney;
  String numMarketPairs;
  String hightValue;
  String slug;
  String percentChangeOneH;
  Color colorValues;

  _ShowCryptoMoneys(backgroundColor, iconData, cryptoMoney,
      numMarketPairs, hightValue, slug,
      percentChangeOneH, colorValues) {
    this.backgroundColor = backgroundColor;
    this.iconData = iconData;
    this.cryptoMoney = cryptoMoney;
    this.numMarketPairs = numMarketPairs;
    this.hightValue = hightValue;
    this.slug = slug;
    this.percentChangeOneH = percentChangeOneH;
    this.colorValues = colorValues;
  }
}

class _CriptoMoneyCard extends StatelessWidget {

  final Color backgroundColor;
  final IconData iconData;
  final String cryptoMoney;
  final String numMarketPairs;
  final String hightValue;
  final String slug;
  final String percentChangeOneH;
  final Color colorValues;


  const _CriptoMoneyCard(
      this.backgroundColor, this.iconData, this.cryptoMoney, this.numMarketPairs,
      this.hightValue, this.slug, this.percentChangeOneH, this.colorValues
      );


  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () {
          //print("mostrar info cryptomoneda "+cryptoMoney+" "+slug+" "+hightValue);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddCryptocurrencyUser(
                      cryptocurrency: Cryptocurrency(
                        name: cryptoMoney,
                        price: hightValue,
                        slug: slug,
                        percentChangeOneH: percentChangeOneH,
                      ),
                    )),
          );
        },
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(padding: const EdgeInsets.all(10.0),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 30.0,
                  width: 120.0,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(cryptoMoney, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70)),
                  ),
                ),
                SizedBox(height: 4),
                Text("No. de pares: "+numMarketPairs, style: TextStyle(fontSize: 12, color: Colors.white70)),
                Text("% de cambio 1h: "+percentChangeOneH, style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
            Spacer(flex: 1,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100.0,
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("\$ "+hightValue, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: colorValues)
                        )
                    )
                ),
                SizedBox(height: 25),
              ],
            ),
            Spacer(flex: 1,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0.0, left: 5.0),
                  child: SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 45.0,),
                    ),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
            Spacer(flex: 1,),
          ],
        ),
      ),
    );

  }
}