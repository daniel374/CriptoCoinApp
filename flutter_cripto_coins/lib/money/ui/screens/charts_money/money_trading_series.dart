import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class MoneyTradingSeries {
  final int year;
  final int money_trading;
  final charts.Color barColor;

  MoneyTradingSeries({
    @required this.year,
    @required this.money_trading,
    @required this.barColor
  });

}