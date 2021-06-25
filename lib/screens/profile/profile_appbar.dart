import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/cubit/user_status/user_status_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileAppBar extends StatelessWidget with PreferredSizeWidget {
  final Size preferredSize = Size.fromHeight(146.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: context.read<UserStatusCubit>().isLogged
          ? Container(
              height: 146.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: AllColors.purpleGradient,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(300.0),
                ),
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Positioned(
                    bottom: 20,
                    left: 16,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icons/avatar.png',
                          width: 70,
                          height: 70,
                        ),
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Oleh Chabanov',
                              style: AllStyles.fontSize19w700white,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              context.read<UserStatusCubit>().phoneNumber,
                              style: AllStyles.fontSize14w400white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: AllColors.deepPurple.withOpacity(0.08),
                            offset: Offset(0, 4.0),
                          )
                        ],
                      ),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Image.asset(
                          'assets/images/icons/pencil.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: 112,
            ),
    );
  }
}
