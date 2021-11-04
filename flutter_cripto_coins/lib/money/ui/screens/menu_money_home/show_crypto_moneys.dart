import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

const List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
  StaggeredTile.count(4, 1),
  StaggeredTile.count(4, 1),
  StaggeredTile.count(4, 1),
  StaggeredTile.count(4, 1),
  StaggeredTile.count(4, 1),
];

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
              '03.27.27',
              item["quote"]["USD"]["price"].toString(),
              "104189.00000",
              "36",
              "1.05222",
              "1.05258",
              Colors.blue)
        );
      }

      print(showCrypto);
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
          title: const Text('De Cotizaciones'),
        ),
        body: FutureBuilder(
          future: _listCryptoMOneys,
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              print(snapshot.data);
              return Stack(
                children: [
                  GradientBack("", null),
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
              print(snapshot.hasError);
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
      moneys.add(_CriptoMoneyCard(Colors.black, Icons.radio, money.cripto_money, '03.27.27', money.hight_value, "104189.00000", "36", "1.05222", "1.05258", Colors.blue));
    }

    return moneys.toList();

  }
}

class _ShowCryptoMoneys {

  Color backgroundColor;
  IconData iconData;
  String cripto_money;
  String money_num;
  String hight_value;
  String low_value;
  String differential_value;
  String one_value;
  String two_value;
  Color color_values;

  _ShowCryptoMoneys(backgroundColor, iconData, cripto_money,
      money_num, hight_value,
      low_value, differential_value,
      one_value, two_value, color_values) {
    this.backgroundColor = backgroundColor;
    this.iconData = iconData;
    this.cripto_money = cripto_money;
    this.money_num = money_num;
    this.hight_value = hight_value;
    this.low_value = low_value;
    this.differential_value = differential_value;
    this.one_value = one_value;
    this.two_value = two_value;
    this.color_values = color_values;
  }
}

class _CriptoMoneyCard extends StatelessWidget {

  const _CriptoMoneyCard(
      this.backgroundColor, this.iconData, this.cripto_money, this.money_num,
      this.hight_value, this.low_value, this.differential_value,
      this.one_value, this.two_value, this.color_values
      );

  final Color backgroundColor;
  final IconData iconData;
  final String cripto_money;
  final String money_num;
  final String hight_value;
  final String low_value;
  final String differential_value;
  final String one_value;
  final String two_value;
  final Color color_values;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () {},
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(padding: const EdgeInsets.all(10.0),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(cripto_money, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70)),
                SizedBox(height: 4),
                Text(money_num, style: TextStyle(fontSize: 12, color: Colors.white70)),
                Text("Diferencial: "+differential_value, style: TextStyle(fontSize: 12, color: Colors.white70)),
                /*ListTile(
                  title: Text('AUDNZD'),
                  subtitle: Text('03.27.27'),
                ),*/
              ],
            ),
            Spacer(flex: 1,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(one_value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color_values)),
                SizedBox(height: 25),
                Text("Alto: "+hight_value, style: TextStyle(fontSize: 12, color: Colors.white70 )),
              ],
            ),
            Spacer(flex: 1,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(two_value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color_values)),
                SizedBox(height: 25),
                Text("Bajo: "+low_value, style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
            Spacer(flex: 1,),
          ],
        ),
      ),
    );

  }
}