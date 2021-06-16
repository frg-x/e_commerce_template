import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/ads_cubit.dart';
import 'package:e_commerce_template/cubit/categories_cubit.dart';
import 'package:e_commerce_template/cubit/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/products_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/cubit/user_status_cubit.dart';
import 'package:e_commerce_template/data/shop_repository.dart';
import 'package:e_commerce_template/screens/enter_phone_screen.dart';
import 'package:e_commerce_template/screens/fliter_screen.dart';
import 'package:e_commerce_template/screens/get_started_screen.dart';
import 'package:e_commerce_template/screens/subcatalogue_screen.dart';
import 'package:e_commerce_template/screens/tabs_screen.dart';
import 'package:e_commerce_template/screens/verification_screen.dart';
import 'package:e_commerce_template/screens/verify_user_status_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, /*DeviceOrientation.portraitDown*/
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCubit(ShopRepository())),
        BlocProvider(create: (context) => CategoriesCubit(ShopRepository())),
        BlocProvider(create: (context) => AdsCubit(ShopRepository())),
        BlocProvider(create: (context) => FavoriteCubit(ShopRepository())),
        BlocProvider(create: (context) => FavoriteCubit(ShopRepository())),
        BlocProvider(create: (context) => UserStatusCubit()),
        BlocProvider(create: (context) => ToggleBotNavBarCubit()),
      ],
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          fontFamily: 'SF-Pro-Text',
          accentColor: AllColors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        home: VerifyUserStatusScreen(),
        routes: {
          GetStarted.routeName: (context) => GetStarted(),
          EnterPhoneScreen.routeName: (context) => EnterPhoneScreen(),
          VerificationScreen.routeName: (context) => VerificationScreen(),
          TabsScreen.routeName: (context) => TabsScreen(),
          SubCatalogueScreen.routeName: (context) => SubCatalogueScreen(),
          FilterScreen.routeName: (context) => FilterScreen(),
        },
      ),
    );
  }
}
