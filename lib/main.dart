import 'package:e_commerce_template/cubit/ads_cubit.dart';
import 'package:e_commerce_template/cubit/categories_cubit.dart';
import 'package:e_commerce_template/cubit/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/products_cubit.dart';
import 'package:e_commerce_template/data/shop_repository.dart';
import 'package:e_commerce_template/screens/enter_phone_screen.dart';
import 'package:e_commerce_template/screens/get_started_screen.dart';
import 'package:e_commerce_template/screens/home_screen.dart';
import 'package:e_commerce_template/screens/tabs_screen.dart';
import 'package:e_commerce_template/screens/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final auth = FirebaseAuth.instance;
late Widget initialScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  checkUserStatus();
  runApp(MyApp());
}

void checkUserStatus() {
  auth.authStateChanges().listen((User? user) {
    if (user == null) {
      initialScreen = GetStarted();
    } else {
      initialScreen = TabsScreen(auth: auth);
    }
  });
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProductsCubit(ShopRepository())),
          BlocProvider(create: (context) => CategoriesCubit(ShopRepository())),
          BlocProvider(create: (context) => AdsCubit(ShopRepository())),
          BlocProvider(create: (context) => FavoriteCubit(ShopRepository())),
        ],
        child: initialScreen,
      ),
      routes: {
        EnterPhoneScreen.routeName: (context) => EnterPhoneScreen(),
        VerificationScreen.routeName: (context) => VerificationScreen(),
        TabsScreen.routeName: (context) => TabsScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        GetStarted.routeName: (context) => GetStarted(),
      },
    );
  }
}
