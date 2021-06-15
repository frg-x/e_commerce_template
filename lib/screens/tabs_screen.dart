import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/cubit/user_status_cubit.dart';
import 'package:e_commerce_template/screens/catalogue_screen.dart';
import 'package:e_commerce_template/screens/home_screen.dart';
import 'package:e_commerce_template/widgets/appbar/catalogue_appbar.dart';
import 'package:e_commerce_template/widgets/appbar/home_appbar.dart';
import 'package:e_commerce_template/widgets/my_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _tabPages = [
    {
      'body': HomeScreen(),
      'appBar': HomeAppBar(),
    },
    {
      'body': CatalogueScreen(),
      'appBar': CatalogueAppBar(),
    },
    {
      'body': Container(
        child: Center(child: Text('Favorite')),
      ),
      'appBar': AppBar(
        title: Text('Favorite'),
      )
    },
    {
      'body': Container(
        child: Center(child: Text('Profile')),
      ),
      'appBar': AppBar(
        title: Text('Profile'),
      ),
    }
  ];

  void getCurrentUser() {
    var user = context.read<UserStatusCubit>().user;
    if (user != null) {
      print(user.phoneNumber);
      print(user.uid);
      context.read<FavoriteCubit>().setUserId(user.uid);
      context.read<FavoriteCubit>().getFavorite();
    } else {
      context.read<FavoriteCubit>().favProducts = [];
    }
  }

  @override
  void initState() {
    //print('Current user is: ${context.read<UserStatusCubit>().user}');
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleBotNavBarCubit, ToggleBotNavBarState>(
      builder: (context, innerState) {
        if (innerState is GetSelectedIndex) {
          return Scaffold(
            appBar: _tabPages[innerState.index]['appBar'],
            backgroundColor: AllColors.tabsScreenBgColor,
            extendBody: true,
            body: _tabPages[innerState.index]['body'],
            bottomNavigationBar: MyBottomNavBar(),
          );
        } else
          return Container();
      },
    );
  }
}
