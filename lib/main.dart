import 'package:app_demo/pages/pages.dart';
import 'package:app_demo/services/auth_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Wrapper(),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/home': (context) => Home(),
          '/add': (context) => AddData(),
        },
      ),
    );
  }
}
