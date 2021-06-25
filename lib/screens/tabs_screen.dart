import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/cubit/user_status/user_status_cubit.dart';
import 'package:e_commerce_template/widgets/my_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

String formatPhoneNumber(String phoneNumber) {
  RegExp phone = RegExp(r'(\+)(\d{2})(\d{3})(\d{3})(\d{2})(\d{2})');
  var matches = phone.allMatches(phoneNumber);
  var match = matches.elementAt(0);
  String formatted =
      '${match.group(1)}${match.group(2)} (${match.group(3)}) ${match.group(4)} ${match.group(5)} ${match.group(6)}';
  return formatted;
}

class _TabsScreenState extends State<TabsScreen> {
  Future<void> getCurrentUser() async {
    var user = context.read<UserStatusCubit>().user;
    bool isContainsFavs;

    if (user != null) {
      print(user.phoneNumber);
      print(user.uid);
      context.read<UserStatusCubit>().phoneNumber =
          formatPhoneNumber(user.phoneNumber!);
      context.read<FavoriteCubit>().setUserId(user.uid);
      context.read<FavoriteCubit>().getFavorite();
      print(user);

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((onValue) {
        if (onValue.exists) {
          isContainsFavs = onValue.data()!.containsKey('favProducts');
          if (!isContainsFavs) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({'favProducts': []});
          }
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({'favProducts': []});
        }
      });
    } else {
      context.read<FavoriteCubit>().favProductsIds = [];
    }
  }

  @override
  void initState() {
    print('Current user is: ${context.read<UserStatusCubit>().user}');
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<FavoriteCubit>().favoriteProducts);
    print(context.read<FavoriteCubit>().favProductsIds);
    return BlocBuilder<ToggleBotNavBarCubit, ToggleBotNavBarState>(
      builder: (context, state) {
        int selectedIndex = (state as GetSelectedIndex).index;
        return Scaffold(
          appBar: tabPages[selectedIndex]['appBar'],
          backgroundColor: AllColors.tabsScreenBgColor,
          extendBody: true,
          body: tabPages[selectedIndex]['body'],
          bottomNavigationBar: MyBottomNavBar(),
        );
      },
    );
  }
}
