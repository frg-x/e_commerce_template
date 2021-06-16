import 'dart:ui';
import 'package:e_commerce_template/screens/catalogue_screen.dart';
import 'package:e_commerce_template/screens/home_screen.dart';
import 'package:e_commerce_template/widgets/appbar/catalogue_appbar.dart';
import 'package:e_commerce_template/widgets/appbar/home_appbar.dart';
import 'package:flutter/material.dart';

const int autoScrollDuration = 5;

class AllColors {
  static const getStartedContainerOverlay = Color(0xFF2A034B);
  static const phoneNumTextFieldBorder = Color(0xFFE1E1E1);
  static const mainYellow = Color(0xFFE7B944);
  static const tabsScreenBgColor = Color(0xFFE5E5E5);
  static const lightGray = Color(0xFF9B9B9B);
  static const activeTabTextColor = Color(0xFF40304D);
  static const deepPurple = Color(0xFF34283E);

  static const List<Color> purpleGradient = [
    AllColors.deepPurple,
    Color(0xFF845FA1),
  ];

  static final List<Color> advCardOverlayGradient = [
    AllColors.deepPurple.withOpacity(1.0),
    Color(0xFF1D2332).withOpacity(0.2),
  ];

  static const circularProgressIndicatorColor = Color(0xFF663399);

  static const lightPurpleGray = Color(0XFF605A65);

  static const List<Color> discountLabelGradientColors = [
    Color(0xFFD23A3A),
    Color(0xFFF49763),
  ];

  static const ratingStarColor = Color(0xFFF2994A);
}

class AllStyles {
  static const getStartedTitle31_My = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 31.0,
    fontWeight: FontWeight.w800,
    color: AllColors.mainYellow,
  );

  static const getStartedTitle31_Shop = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 31.0,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );
  static const getStartedSubText = TextStyle(
    fontSize: 14.0,
    height: 1.35,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static final getStartedMainButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      AllColors.mainYellow,
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );

  static const fontSize17w700white = TextStyle(
    fontSize: 17.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  static const fontSize17w700 = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
  );

  static const fontSize14w400 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static const fontSize14w400white = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static const fontSize14w600 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.15,
    color: Colors.white,
  );

  static const fontSize13w500 = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
  );

  static const fontSize17w700lightGray = TextStyle(
    fontSize: 17.0,
    color: AllColors.lightGray,
    fontWeight: FontWeight.w700,
  );

  static const SFProDisplay25w700white = TextStyle(
    fontFamily: 'SF-Pro-Display',
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static const SFProText12w700mainYellow = TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: AllColors.mainYellow,
  );

  static const bottomNavBarDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(80.0),
      bottomLeft: Radius.circular(80.0),
    ),
    gradient: LinearGradient(
      colors: AllColors.purpleGradient,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      transform: GradientRotation(263 / 360),
    ),
  );

  static const cartTotalSumTextStyle = TextStyle(
    fontSize: 11.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.07,
  );

  static final cartTotalItemsTextStyle = TextStyle(
    fontSize: 11.0,
    color: Colors.white.withOpacity(0.6),
    fontWeight: FontWeight.w700,
    letterSpacing: 0.07,
  );

  static const bottomNavBarItemTextStyle = TextStyle(
    fontSize: 10,
    letterSpacing: 0.07,
    height: 0.85,
    fontWeight: FontWeight.w700,
  );

  static const homeTitleTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 2.0,
  );

  static const homeCatItemTextStyle = TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: Colors.white,
    letterSpacing: -0.15,
  );

  static const homeCatTitleTextStyle = TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontWeight: FontWeight.w700,
    fontSize: 19.0,
    letterSpacing: -0.49,
    color: AllColors.deepPurple,
  );

  static const SFProText12w700lightGray = TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: AllColors.lightGray,
  );

  static const SFProDisplay14w600lightGray = TextStyle(
    color: AllColors.lightGray,
    fontFamily: 'SF-Pro-Display',
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
  );

  static const fontSize17w400 = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w400,
  );

  static const SFProDisplay25w700 = TextStyle(
    fontFamily: 'SF-Pro-Display',
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
  );

  static const SFProDisplay12w400deepPurpleUnderline = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AllColors.deepPurple,
    decoration: TextDecoration.underline,
  );

  static const SFProDisplay17w700deepPurple = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
    color: AllColors.deepPurple,
  );

  static const discountPriceLabelTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.41,
    color: Color(0xFFCE3E3E),
  );

  static const oldPriceLabelTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.15,
    color: AllColors.lightGray,
    decoration: TextDecoration.lineThrough,
  );

  static const fontSize11w700white = TextStyle(
    fontSize: 11.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  static const fontSize12w700lightGray = TextStyle(
    fontSize: 12.0,
    color: AllColors.lightGray,
    fontWeight: FontWeight.w700,
  );

  static const fontSize12w700deepPurple = TextStyle(
    fontSize: 12.0,
    color: AllColors.deepPurple,
    fontWeight: FontWeight.w700,
  );

  static const fontSize17w700deepPurple = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
    color: AllColors.deepPurple,
    letterSpacing: -0.41,
  );

  static const fontSize19w700deepPurple = TextStyle(
    fontSize: 19.0,
    fontWeight: FontWeight.w700,
    color: AllColors.deepPurple,
    letterSpacing: -0.49,
  );

  static const fontSize19w700white = TextStyle(
    fontSize: 19.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: -0.49,
  );

  static const fontSize14w400lightPurpleGray = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AllColors.lightPurpleGray,
    letterSpacing: -0.15,
  );

  static final InputDecoration searchInputDecoration = InputDecoration(
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

final List<Map<String, dynamic>> tabPages = [
  {
    'body': HomeScreen(),
    'appBar': HomeAppBar(),
  },
  {
    'body': CatalogueScreen(),
    'appBar': CatalogueAppBar(),
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
