import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/cubit/user_status/user_status_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteAppBar extends StatelessWidget with PreferredSizeWidget {
  final Size preferredSize = Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: context.read<UserStatusCubit>().isLogged
          ? Container(
              height: 88.0,
              padding: EdgeInsets.only(left: 19.0, right: 19.0, bottom: 19.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: AllColors.purpleGradient,
                ),
              ),
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 24.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      'Favorite',
                      style: AllStyles.fontSize19w700white,
                    ),
                    const SizedBox(
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
