import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'bottom_navbar_button.dart';

class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  late bool isCartOpened;
  late double cartOffset;
  late double bottomIconsOffset;

  void slideCart() {
    if (isCartOpened) {
      setState(() {
        cartOffset = 0;
        bottomIconsOffset = 75;
        isCartOpened = !isCartOpened;
      });
    } else {
      setState(() {
        cartOffset = -65;
        bottomIconsOffset = 0;
        isCartOpened = !isCartOpened;
      });
    }
  }

  @override
  void initState() {
    isCartOpened = false;
    slideCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 87.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(5.0, 0),
                blurRadius: 15.0,
                color: Colors.black.withOpacity(0.05),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavBarButton(
                    title: 'Home',
                    image:
                        context.read<ToggleBotNavBarCubit>().selectedIndex == 0
                            ? 'assets/images/icons/bottom_home_icon_active.svg'
                            : 'assets/images/icons/bottom_home_icon.svg',
                    color:
                        context.read<ToggleBotNavBarCubit>().selectedIndex == 0
                            ? AllColors.activeTabTextColor
                            : AllColors.lightGray,
                    onPress: () {
                      context
                          .read<ToggleBotNavBarCubit>()
                          .toggleBottomNavBarMenu(0);
                    },
                  ),
                  BottomNavBarButton(
                    title: 'Catalogue',
                    image:
                        context.read<ToggleBotNavBarCubit>().selectedIndex == 1
                            ? 'assets/images/icons/bottom_cat_icon_active.svg'
                            : 'assets/images/icons/bottom_cat_icon.svg',
                    color:
                        context.read<ToggleBotNavBarCubit>().selectedIndex == 1
                            ? AllColors.activeTabTextColor
                            : AllColors.lightGray,
                    onPress: () {
                      context
                          .read<ToggleBotNavBarCubit>()
                          .toggleBottomNavBarMenu(1);
                    },
                  ),
                  BottomNavBarButton(
                    title: 'Favorite',
                    image:
                        context.read<ToggleBotNavBarCubit>().selectedIndex == 2
                            ? 'assets/images/icons/bottom_fav_icon_active.svg'
                            : 'assets/images/icons/bottom_fav_icon.svg',
                    color:
                        context.read<ToggleBotNavBarCubit>().selectedIndex == 2
                            ? AllColors.activeTabTextColor
                            : AllColors.lightGray,
                    onPress: () {
                      context
                          .read<ToggleBotNavBarCubit>()
                          .toggleBottomNavBarMenu(2);
                    },
                  ),
                  BottomNavBarButton(
                    title: 'Profile',
                    image: context.read<ToggleBotNavBarCubit>().selectedIndex ==
                            3
                        ? 'assets/images/icons/bottom_profile_icon_active.svg'
                        : 'assets/images/icons/bottom_profile_icon.svg',
                    color:
                        context.read<ToggleBotNavBarCubit>().selectedIndex == 3
                            ? AllColors.activeTabTextColor
                            : AllColors.lightGray,
                    onPress: () {
                      context
                          .read<ToggleBotNavBarCubit>()
                          .toggleBottomNavBarMenu(3);
                    },
                  ),
                  AnimatedContainer(
                    width: bottomIconsOffset,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  ),
                ],
              ),
              color: Colors.white,
            ),
          ),
        ),
        AnimatedPositioned(
          right: cartOffset,
          top: -11,
          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: Container(
            height: 56.0,
            width: 116.0,
            decoration: AllStyles.bottomNavBarDecoration,
            child: InkWell(
              onDoubleTap: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              onTap: slideCart,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        child: Ink.image(
                          image: Svg('assets/images/icons/cart_icon.svg'),
                          fit: BoxFit.scaleDown,
                          width: 28.0,
                          height: 28.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        int cartItemsCount =
                            (state as CartInitial).cartItemCount;
                        double cartTotalSum = state.cartSum;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${cartTotalSum.toStringAsFixed(2)}',
                              style: AllStyles.cartTotalSumTextStyle,
                            ),
                            Text(
                              '$cartItemsCount items',
                              style: AllStyles.cartTotalItemsTextStyle,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
