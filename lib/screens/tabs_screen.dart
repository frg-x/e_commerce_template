import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/ads_cubit.dart';
import 'package:e_commerce_template/cubit/categories_cubit.dart';
import 'package:e_commerce_template/cubit/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/products_cubit.dart';
import 'package:e_commerce_template/widgets/my_app_bar.dart';
import 'package:e_commerce_template/widgets/my_bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  final auth;
  TabsScreen({this.auth});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  User? loggedInUser;
  String? uid;

  List<Map<String, dynamic>> _tabPages = [
    {
      'body': HomeScreen(),
      'appBar': MyAppBar(),
    },
    {
      'body': Container(
        child: Center(child: Text('Catalogue')),
      ),
      'appBar': AppBar(title: Text('Catalogue')),
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

  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getCurrentUser() async {
    try {
      final user = widget.auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        //uid = FirebaseAuth.instance.currentUser!.uid;
        uid = user.uid;
        print(user.phoneNumber);
        print(user.uid);
        context.read<FavoriteCubit>().setUserId(uid!);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
    context.read<CategoriesCubit>().getCategories();
    context.read<AdsCubit>().getAds();
    getCurrentUser();
    context.read<FavoriteCubit>().getFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _tabPages[_selectedIndex]['appBar'],
      backgroundColor: AllColors.tabsScreenBgColor,
      extendBody: true,
      body: _tabPages[_selectedIndex]['body'],
      bottomNavigationBar: MyBottomNavBar(_selectPage),
    );
  }
}
