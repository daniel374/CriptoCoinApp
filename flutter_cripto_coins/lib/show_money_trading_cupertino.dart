import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/User/ui/screens/profile_money_trading.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'money/ui/screens/home_money_trading.dart';
import 'money/ui/screens/search_money_trading.dart';

class ShowMoneyTradingCupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.indigo),
                  title: Text("")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search, color: Colors.indigo),
                  title: Text("")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.indigo),
                  title: Text("")
              ),
            ]
        ),

        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) => HomeMoneyTrading(),
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) => SearchMoneyTrading(),
              );
              break;
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return BlocProvider<UserBloc>(
                      child: ProfileMoneyTrading(),
                      bloc: UserBloc()
                  );
                },
              );
              break;

          }

        },
      ),
    );
  }

}