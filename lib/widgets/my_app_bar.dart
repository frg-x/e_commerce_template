import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/screens/get_started_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
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
                  Image.asset('assets/images/icons/drawer_icon.png'),
                  Row(
                    children: [
                      Text(
                        'My',
                        style: AllStyles.homeTitleTextStyle
                            .copyWith(color: AllColors.mainYellow),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Shop',
                        style: AllStyles.homeTitleTextStyle
                            .copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(
                            context, GetStarted.routeName);
                      },
                      child: Image.asset(
                        'assets/images/icons/bell_icon.png',
                        width: 16,
                        height: 18,
                      ),
                    ),
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
                    decoration: searchInputDecoration(),
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

  InputDecoration searchInputDecoration() {
    return InputDecoration(
      prefixIcon: Image.asset(
        'assets/images/icons/search_icon.png',
        width: 18.0,
        height: 18.0,
      ),
      //isDense: true,
      filled: true,
      focusColor: Colors.white,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.only(top: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(40),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(40),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(40),
      ),
      hintText: 'What are you looking for?',
      hintStyle: AllStyles.SFProDisplay14w600lightGray,
    );
  }
}
