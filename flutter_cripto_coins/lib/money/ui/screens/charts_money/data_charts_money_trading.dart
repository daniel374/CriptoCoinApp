import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_cripto_coins/money/ui/screens/charts_money/money_trading_series.dart';

import 'charts_money_trading.dart';


class DataChartsMoneyTrading extends StatelessWidget {


  final List<MoneyTradingSeries> data = [
    MoneyTradingSeries(year: 2017, money_trading: 40000, barColor: charts.ColorUtil.fromDartColor(Colors.green),),
    MoneyTradingSeries(year: 2018, money_trading: 5000, barColor: charts.ColorUtil.fromDartColor(Colors.green),),
    MoneyTradingSeries(year: 2019, money_trading: 40000, barColor: charts.ColorUtil.fromDartColor(Colors.green),),
    MoneyTradingSeries(year: 2020, money_trading: 35000, barColor: charts.ColorUtil.fromDartColor(Colors.green),),
    MoneyTradingSeries(year: 2021, money_trading: 45000, barColor: charts.ColorUtil.fromDartColor(Colors.green),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadisticas'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ChartsMoneyTrading(data),
      ),
    );
  }
}