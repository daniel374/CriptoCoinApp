import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';
import 'package:flutter_cripto_coins/widgets/button_purple.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';
import 'package:flutter_cripto_coins/widgets/title_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OhlcData {
  final DateTime timeOhlc;
  final double open;
  final double high;
  final double low;
  final double close;

  OhlcData({this.timeOhlc, this.open, this.high, this.low, this.close});
}

class AddCryptocurrencyUser extends StatefulWidget {
  final Cryptocurrency cryptocurrency;

  AddCryptocurrencyUser({
    Key key,
    @required this.cryptocurrency,
  });

  @override
  State<AddCryptocurrencyUser> createState() => _AddCryptocurrencyUserState();
}

class _AddCryptocurrencyUserState extends State<AddCryptocurrencyUser> {
  Future futureOhlc;

  List<OhlcData> _dataOhlc;
  TrackballBehavior _trackballBehavior;
  ZoomPanBehavior _zoomPanBehavior;
  String interval = "1";

  @override
  void initState() {
    futureOhlc =
        fetchCandles(symbol: widget.cryptocurrency.slug, interval: interval);
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    _zoomPanBehavior = ZoomPanBehavior(enableDoubleTapZooming: true);
    super.initState();
    print(futureOhlc.toString());
  }

  Future fetchCandles({String symbol, String interval}) async {
    final uri = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/$symbol/ohlc?vs_currency=usd&days=$interval");
    print("uri " + uri.toString());
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = json.decode(res.body);
      print("data " + data.toString());
      _dataOhlc = getChartData(data);
      return _dataOhlc;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ohlc');
    }
  }

  List<OhlcData> getChartData(data) {
    List<OhlcData> dataChartOhlc = [];
    setState(() {
      for (var i = 0; i < data.length; i++) {
        dataChartOhlc.add(OhlcData(
            timeOhlc: DateTime.fromMicrosecondsSinceEpoch(data[i][0]),
            open: data[i][1],
            high: data[i][2],
            low: data[i][3],
            close: data[i][4]));
      }
    });
    print("tiempos " + dataChartOhlc.toString());
    return dataChartOhlc;
  }

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final _controllerTitlePlace = TextEditingController();
    final _controllerDespCrypto = TextEditingController();
    DateTime dateNow = new DateTime.now();

    return Scaffold(
      body: Stack(
        children: [
          GradientBack(
            height: 300.0,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 5.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 45.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Flexible(
                  child: Container(
                padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                child: TitleHeader(
                  title: "Generar cotización",
                  fontSize: 30.0,
                  colorTitle: Colors.white,
                ),
              )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SfCartesianChart(
                    zoomPanBehavior: _zoomPanBehavior,
                    trackballBehavior: _trackballBehavior,
                    plotAreaBorderWidth: 5,
                    plotAreaBorderColor: Colors.red,
                    plotAreaBackgroundColor: Colors.black87,
                    series: <CandleSeries>[
                      CandleSeries<OhlcData, DateTime>(
                        dataSource: _dataOhlc,
                        xValueMapper: (OhlcData sales, _) => sales.timeOhlc,
                        lowValueMapper: (OhlcData sales, _) => sales.low,
                        highValueMapper: (OhlcData sales, _) => sales.high,
                        openValueMapper: (OhlcData sales, _) => sales.open,
                        closeValueMapper: (OhlcData sales, _) => sales.close,
                      )
                    ],
                    primaryXAxis: DateTimeAxis(
                        majorGridLines: MajorGridLines(
                      width: 0,
                    )),
                    primaryYAxis: NumericAxis(
                      numberFormat:
                          NumberFormat.simpleCurrency(decimalDigits: 0),
                    ),
                  ),
                ),
                /*Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: TextInputField(
                      hintText: "Title",
                      inpuType: null,
                      maxLines: 1,
                      controller: _controllerTitlePlace,
                    )),
                TextInputField(
                  hintText: "Description",
                  inpuType: TextInputType.multiline,
                  maxLines: 4,
                  controller: _controllerDespCrypto,
                ),*/
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: TitleHeader(
                    title: widget.cryptocurrency.name,
                    fontSize: 30.0,
                    colorTitle: Colors.blue,
                  ),
                ),
                Container(
                  width: 70.0,
                  child: ButtonPurple(
                    buttonText: "Cotizar",
                    onPressed: () {
                      //Cloud Firestore
                      userBloc
                          .updateCryptocurrencyData(Cryptocurrency(
                        id: widget.cryptocurrency.id,
                        name: widget.cryptocurrency.name,
                        slug: widget.cryptocurrency.slug,
                        sharesCount: widget.cryptocurrency.sharesCount,
                        moneyInvested: widget.cryptocurrency.moneyInvested,
                        price: widget.cryptocurrency.price,
                        purchaseDate: dateNow.toString(),
                        percentChangeOneH:
                            widget.cryptocurrency.percentChangeOneH,
                        status: "Cotizando",
                      ))
                          .whenComplete(() {
                        print("Termino cotizacion");
                        Navigator.pop(context);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
