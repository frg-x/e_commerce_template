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
            colors: [
              Color(0xFF34283E),
              Color(0xFF845FA1),
            ],
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
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFE7B944),
                          letterSpacing: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Shop',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
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
                    decoration: InputDecoration(
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
                        hintStyle: TextStyle(
                          color: Color(0xFF9B9B9B),
                          fontFamily: 'SF-Pro-Display',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        )),
                    style: TextStyle(
                      color: Color(0xFF9B9B9B),
                      fontFamily: 'SF-Pro-Display',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
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
