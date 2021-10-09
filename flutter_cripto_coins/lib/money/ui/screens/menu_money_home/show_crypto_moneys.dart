import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
  StaggeredTile.count(4, 1),
  StaggeredTile.count(4, 1),
  StaggeredTile.count(4, 1),
  StaggeredTile.count(4, 1),
  StaggeredTile.count(4, 1),
];

const List<Widget> _tiles = <Widget>[
  _ShowCryptoMoneys(Colors.black, Icons.radio, "AUDNZD", '03.27.27', "105361.00000", "104189.00000", "36", "1.05222", "1.05258", Colors.blue),
  _ShowCryptoMoneys(Colors.black, Icons.radio, "AUDCHF", '12.00.00', "--", "--", "0", "0.00000", "0.00000", Colors.blue),
  _ShowCryptoMoneys(Colors.black, Icons.radio, "AUDCAD", '03.27.37', "92268.00000", "91717.00000", "24", "0.91725", "0.91749", Colors.blue),
  _ShowCryptoMoneys(Colors.black, Icons.radio, "AUDJPY", '03.27.28', "80.234", "79.573", "28", "79.632", "79.660", Colors.red),
  _ShowCryptoMoneys(Colors.black, Icons.radio, "CHFJPY", '03.27.36', "120.098", "119.567", "21", "120.063", "120.084", Colors.blue),
];


class ShowCryptoMoneys extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('De Cotizaciones'),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              padding: const EdgeInsets.all(4),
              children: _tiles,
            )));
  }
}

class _ShowCryptoMoneys extends StatelessWidget {

  const _ShowCryptoMoneys(
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