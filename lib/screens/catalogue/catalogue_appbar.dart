import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CatalogueAppBar extends StatelessWidget with PreferredSizeWidget {
  final Size preferredSize = Size.fromHeight(110.0);
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
                      },
                      child: SvgPicture.asset(
                        'assets/images/icons/arrow_left_white.svg',
                      ),
                    ),
                  ),
                  Text(
                    'Catalogue',
                    style: AllStyles.fontSize19w700white,
                  ),
                  const SizedBox(width: 24.0),
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
