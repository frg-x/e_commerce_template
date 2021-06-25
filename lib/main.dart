import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/ads/ads_cubit.dart';
import 'package:e_commerce_template/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_template/cubit/categories/categories_cubit.dart';
import 'package:e_commerce_template/cubit/delivery/delivery_cubit.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/filter/filter_cubit.dart';
import 'package:e_commerce_template/cubit/products/products_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/cubit/user_status/user_status_cubit.dart';
import 'package:e_commerce_template/data/shop_repository.dart';
import 'package:e_commerce_template/model/filter.dart';
import 'package:e_commerce_template/screens/cart/cart_screen.dart';
import 'package:e_commerce_template/screens/checkout/checkout_screen.dart';
import 'package:e_commerce_template/screens/sign_and_verify_screens/enter_phone_screen.dart';
import 'package:e_commerce_template/screens/filter/fliter_screen.dart';
import 'package:e_commerce_template/screens/sign_and_verify_screens/get_started_screen.dart';
import 'package:e_commerce_template/screens/product/product_screen.dart';
import 'package:e_commerce_template/screens/subcatalogue/subcatalogue_screen.dart';
import 'package:e_commerce_template/screens/tabs_screen.dart';
import 'package:e_commerce_template/screens/sign_and_verify_screens/verification_screen.dart';
import 'package:e_commerce_template/screens/verify_user_status_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/product_page_options/product_page_options_cubit.dart';

void main() async {
  print('Calling void main()');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, /*DeviceOrientation.portraitDown*/
  ]).then((_) => runApp(MyApp()));
}

// class MyApp extends StatelessWidget {
//   static Widget? _appCache;
//
//   @override
//   Widget build(BuildContext context) {
//     if (_appCache == null) _appCache = _buildApp();
//     return _appCache!;
//   }
//
//   static Widget _buildApp() {
//     print('Starting MyApp');
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => ProductsCubit(ShopRepository(), [])),
//         BlocProvider(create: (context) => CategoriesCubit(ShopRepository())),
//         BlocProvider(create: (context) => AdsCubit(ShopRepository())),
//         BlocProvider(create: (context) => FavoriteCubit(ShopRepository())),
//         BlocProvider(create: (context) => UserStatusCubit()),
//         BlocProvider(create: (context) => ToggleBotNavBarCubit()),
//         BlocProvider(create: (context) => FilterCubit(Filter())),
//         BlocProvider(create: (context) => ProductPageOptionsCubit()),
//         BlocProvider(create: (context) => CartCubit([], 0, 0)),
//         BlocProvider(create: (context) => DeliveryCubit(0)),
//       ],
//       child: MaterialApp(
//         title: 'My Shop',
//         theme: ThemeData(
//           fontFamily: 'SF-Pro-Text',
//           accentColor: AllColors.deepPurple,
//           buttonTheme: ButtonThemeData(hoverColor: AllColors.deepPurple),
//         ),
//         debugShowCheckedModeBanner: false,
//         home: VerifyUserStatusScreen(),
//         routes: {
//           GetStarted.routeName: (context) => GetStarted(),
//           EnterPhoneScreen.routeName: (context) => EnterPhoneScreen(),
//           VerificationScreen.routeName: (context) => VerificationScreen(),
//           TabsScreen.routeName: (context) => TabsScreen(),
//           SubCatalogueScreen.routeName: (context) => SubCatalogueScreen(),
//           FilterScreen.routeName: (context) => FilterScreen(),
//           ProductScreen.routeName: (context) => ProductScreen(),
//           CartScreen.routeName: (context) => CartScreen(),
//           CheckoutScreen.routeName: (context) => CheckoutScreen(),
//           VerifyUserStatusScreen.routeName: (context) =>
//               VerifyUserStatusScreen(),
//         },
//       ),
//     );
//    }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Starting MyApp');
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCubit(ShopRepository(), [])),
        BlocProvider(create: (context) => CategoriesCubit(ShopRepository())),
        BlocProvider(create: (context) => AdsCubit(ShopRepository())),
        BlocProvider(create: (context) => FavoriteCubit(ShopRepository())),
        BlocProvider(create: (context) => UserStatusCubit()),
        BlocProvider(create: (context) => ToggleBotNavBarCubit()),
        BlocProvider(create: (context) => FilterCubit(Filter())),
        BlocProvider(create: (context) => ProductPageOptionsCubit()),
        BlocProvider(create: (context) => CartCubit([], 0, 0)),
        BlocProvider(create: (context) => DeliveryCubit(0)),
      ],
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          fontFamily: 'SF-Pro-Text',
          accentColor: AllColors.deepPurple,
          buttonTheme: ButtonThemeData(hoverColor: AllColors.deepPurple),
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
          ProductScreen.routeName: (context) => ProductScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          CheckoutScreen.routeName: (context) => CheckoutScreen(),
          VerifyUserStatusScreen.routeName: (context) =>
              VerifyUserStatusScreen(),
        },
      ),
    );
  }
}
