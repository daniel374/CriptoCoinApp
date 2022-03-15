import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/User/bloc/bloc_user.dart';
import 'package:flutter_cripto_coins/User/ui/screens/in_app_screen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cripto Coins',
          home: InAppScreen(),
          //home: RegisterScreen(),
          //home: MenuOperations(),
          // home: HistoryOperations(),
        ),
        bloc: UserBloc());
  }
}
