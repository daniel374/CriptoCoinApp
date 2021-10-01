import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_cripto_coins/money/ui/screens/charts_money/money_trading_series.dart';


class ChartsMoneyTrading extends StatefulWidget {

  final List<MoneyTradingSeries> data;

  ChartsMoneyTrading(this.data);

  @override
  State createState() {
    return _ChartsMoneyTrading(data);
  }
}

class _ChartsMoneyTrading extends State<ChartsMoneyTrading> {

  final List<MoneyTradingSeries> data;

  _ChartsMoneyTrading(this.data);

  @override
  Widget build(BuildContext context) {

    List<charts.Series<MoneyTradingSeries, num>> series = [
      charts.Series(
        id: "developers",
        data: data,
        domainFn: (MoneyTradingSeries series, _) => series.year,
        measureFn: (MoneyTradingSeries series, _) => series.money_trading,
        colorFn: (MoneyTradingSeries series, _) => series.barColor
      )
    ];

    return Expanded(child: charts.LineChart(series,
                    domainAxis: const charts.NumericAxisSpec(
                        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
                      viewport: charts.NumericExtents(2016.0, 2022.0),
                    ), animate: true,),);
  }
}