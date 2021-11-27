import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:flutter_cripto_coins/money/ui/screens/charts_money/money_trading_series.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Candle>> fetchCandles(
    {String symbol, String interval}) async {
  final uri = Uri.parse(
      "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval&limit=1000");
  final res = await http.get(uri);
  return (jsonDecode(res.body) as List<dynamic>)
      .map((e) => Candle.fromJson(e))
      .toList()
      .reversed
      .toList();
}

class ChartsMoneyTrading extends StatefulWidget {
  @override
  State createState() => _ChartsMoneyTrading();
}

class _ChartsMoneyTrading extends State<ChartsMoneyTrading> {
  List<Candle> candles = [];
  WebSocketChannel _channel;

  String interval = "1m";

  void binanceFetch(String interval) {
    fetchCandles(symbol: "BTCUSDT", interval: interval).then(
          (value) => setState(
            () {
          this.interval = interval;
          candles = value;
        },
      ),
    );
    if (_channel != null) _channel.sink.close();
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );
    _channel.sink.add(
      jsonEncode(
        {
          "method": "SUBSCRIBE",
          "params": ["btcusdt@kline_" + interval],
          "id": 1
        },
      ),
    );
  }

  @override
  void initState() {
    binanceFetch("1m");
    super.initState();
  }

  @override
  void dispose() {
    if (_channel != null) _channel.sink.close();
    super.dispose();
  }

  void updateCandlesFromSnapshot(AsyncSnapshot<Object> snapshot) {
    if (snapshot.data != null) {
      final data = jsonDecode(snapshot.data as String) as Map<String, dynamic>;
      if (data.containsKey("k") == true &&
          candles[0].date.millisecondsSinceEpoch == data["k"]["t"]) {
        candles[0] = Candle(
            date: candles[0].date,
            high: double.parse(data["k"]["h"]),
            low: double.parse(data["k"]["l"]),
            open: double.parse(data["k"]["o"]),
            close: double.parse(data["k"]["c"]),
            volume: double.parse(data["k"]["v"]));
      } else if (data.containsKey("k") == true &&
          data["k"]["t"] - candles[0].date.millisecondsSinceEpoch ==
              candles[0].date.millisecondsSinceEpoch -
                  candles[1].date.millisecondsSinceEpoch) {
        candles.insert(
            0,
            Candle(
                date: DateTime.fromMillisecondsSinceEpoch(data["k"]["t"]),
                high: double.parse(data["k"]["h"]),
                low: double.parse(data["k"]["l"]),
                open: double.parse(data["k"]["o"]),
                close: double.parse(data["k"]["c"]),
                volume: double.parse(data["k"]["v"])));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("candleSticks"),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.2,
          child: StreamBuilder(
            stream: _channel == null ? null : _channel.stream,
            builder: (context, snapshot) {
              updateCandlesFromSnapshot(snapshot);
              return Candlesticks(
                onIntervalChange: (String value) async {
                  binanceFetch(value);
                },
                candles: candles,
                interval: interval,
              );
            },
          ),
        ),
      ),
    );
  }
}