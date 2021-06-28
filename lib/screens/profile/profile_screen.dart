import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/cubit/user_status/user_status_cubit.dart';
import 'package:e_commerce_template/screens/profile/rounded_container.dart';
import 'package:e_commerce_template/screens/sign_and_verify_screens/get_started_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return context.read<UserStatusCubit>().isLogged
        ? SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    RoundedContainer(
                      image: 'assets/images/icons/location-marker.png',
                      title: 'Shipping Addresses',
                      onPress: () {
                        print('Shipping Address');
                      },
                    ),
                    const SizedBox(height: 16),
                    RoundedContainer(
                      image: 'assets/images/icons/credit-card.png',
                      title: 'Payment Method',
                      onPress: () {
                        print('Payment Method');
                      },
                    ),
                    const SizedBox(height: 16),
                    RoundedContainer(
                      image: 'assets/images/icons/clipboard-list.png',
                      title: 'Orders',
                      onPress: () {
                        print('Orders');
                      },
                    ),
                    const SizedBox(height: 16),
                    RoundedContainer(
                      image: 'assets/images/icons/favorite.png',
                      title: 'Favorite',
                      onPress: () {
                        context
                            .read<ToggleBotNavBarCubit>()
                            .toggleBottomNavBarMenu(2);
                      },
                    ),
                    const SizedBox(height: 16),
                    RoundedContainer(
                      image: 'assets/images/icons/settings.png',
                      title: 'Settings',
                      onPress: () {
                        print('Settings');
                      },
                    ),
                    const SizedBox(height: 16),
                    RoundedContainer(
                      image: 'assets/images/icons/logout.png',
                      title: 'Log Out',
                      onPress: () => showAlertDialog(context),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Privacy Policy',
                      style: AllStyles.fontSize12w400lightPurpleGray.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(
                      height: 106,
                    )
                  ],
                ),
              ],
            ),
          )
        : Center(
            child: Text(
              'You have not logged in \nto manage your profile',
              style: AllStyles.fontSize14w400lightPurpleGray,
              textAlign: TextAlign.center,
            ),
          );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "No",
      style: AllStyles.fontSize17w700deepPurple,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget yesButton = TextButton(
    child: Text(
      "Yes",
      style: AllStyles.fontSize17w700deepPurple,
    ),
    onPressed: () {
      FirebaseAuth.instance.signOut();
      context.read<FavoriteCubit>().clearFavorites();
      context.read<UserStatusCubit>().logOut();
      context.read<ToggleBotNavBarCubit>().toggleBottomNavBarMenu(0);
      Navigator.pushReplacementNamed(context, GetStarted.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Warning"),
    content: Text(
      "Would you like to Log Out?",
      style: AllStyles.fontSize14w400deepPurple,
    ),
    actions: [
      yesButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
