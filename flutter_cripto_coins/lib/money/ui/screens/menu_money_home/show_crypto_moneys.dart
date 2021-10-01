import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
  StaggeredTile.count(2, 2),
  StaggeredTile.count(2, 1),
  StaggeredTile.count(1, 2),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(1, 2),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(3, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(4, 1),
];

const List<Widget> _tiles = <Widget>[
  _ShowCryptoMoneys(Colors.green, Icons.widgets),
  _ShowCryptoMoneys(Colors.lightBlue, Icons.wifi),
  _ShowCryptoMoneys(Colors.amber, Icons.panorama_wide_angle),
  _ShowCryptoMoneys(Colors.brown, Icons.map),
  _ShowCryptoMoneys(Colors.deepOrange, Icons.send),
  _ShowCryptoMoneys(Colors.indigo, Icons.airline_seat_flat),
  _ShowCryptoMoneys(Colors.red, Icons.bluetooth),
  _ShowCryptoMoneys(Colors.pink, Icons.battery_alert),
  _ShowCryptoMoneys(Colors.purple, Icons.desktop_windows),
  _ShowCryptoMoneys(Colors.blue, Icons.radio),
];


class ShowCryptoMoneys extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('example 01'),
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

  const _ShowCryptoMoneys(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

  }
}