import 'package:e_commerce_template/screens/enter_phone_screen.dart';
import 'package:e_commerce_template/screens/get_started_screen.dart';
import 'package:e_commerce_template/screens/home_screen.dart';
import 'package:e_commerce_template/screens/verification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        fontFamily: 'SF-Pro-Text',
      ),
      debugShowCheckedModeBanner: false,
      // ignore: unnecessary_null_comparison
      home: GetStarted(), //HomeScreen(),
      routes: {
        EnterPhoneScreen.routeName: (context) => EnterPhoneScreen(),
        VerificationScreen.routeName: (context) => VerificationScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
