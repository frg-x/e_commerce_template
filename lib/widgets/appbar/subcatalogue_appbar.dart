import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/screens/fliter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCatalogueAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Size preferredSize = Size.fromHeight(110.0);

  SubCatalogueAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: 110,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: AllColors.purpleGradient,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                      ),
                      onPressed: () {
                        context
                            .read<ToggleBotNavBarCubit>()
                            .toggleBottomNavBarMenu(0);
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/icons/arrow_left.png',
                      ),
                    ),
                  ),
                  Text(
                    title!,
                    style: AllStyles.fontSize19w700white,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerRight,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, FilterScreen.routeName);
                          },
                          child: Image.asset(
                            'assets/images/icons/filter_icon.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Image.asset(
                            'assets/images/icons/filter_circle_icon.png'),
                        width: 8.0,
                        height: 8.0,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withAlpha(25),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: AllStyles.searchInputDecoration,
                    style: AllStyles.SFProDisplay14w600lightGray,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
