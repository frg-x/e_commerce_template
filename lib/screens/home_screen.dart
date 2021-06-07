import 'dart:ui';

import 'package:e_commerce_template/dummy_data.dart';
import 'package:e_commerce_template/screens/favorite_button.dart';
import 'package:e_commerce_template/widgets/advertisement_card.dart';
import 'package:e_commerce_template/widgets/catalogue_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid = '';
  PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    if (FirebaseAuth.instance.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser!.uid;
      print(FirebaseAuth.instance.currentUser!.phoneNumber);
    }
    //print(uid);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: 110.0,
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            //minimumSize: Size(40, 0),
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
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 85.0),
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
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 90.0,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: _pageController,
                          children: [
                            AdvertisementCard(
                              title: 'Fashion Sale',
                              image: 'assets/images/adv_bg.png',
                            ),
                            AdvertisementCard(
                              title: 'New Arrivals',
                              image: 'assets/images/adv_bg.png',
                            ),
                            AdvertisementCard(
                              title: 'Hot Deals',
                              image: 'assets/images/adv_bg.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 28.0),
                    GestureDetector(
                      onTap: () {
                        print('Catalogue Screen');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Catalogue',
                            style: TextStyle(
                              fontFamily: 'SF-Pro-Text',
                              fontWeight: FontWeight.w700,
                              fontSize: 19.0,
                              letterSpacing: -0.49,
                              color: Color(0xFF34283E),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'See All',
                                style: TextStyle(
                                  fontFamily: 'SF-Pro-Text',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF9B9B9B),
                                ),
                              ),
                              SizedBox(width: 2.0),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 14.0,
                                color: Color(0xFF9B9B9B),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      height: 88.0,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        itemCount: categoryItems.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: CatalogueItem(
                              title: categoryItems[index]['title'],
                              image: categoryItems[index]['image'],
                            ),
                          );
                        },
                        separatorBuilder: (context, int index) {
                          return SizedBox(width: 16.0);
                        },
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Featured',
                        style: TextStyle(
                          fontFamily: 'SF-Pro-Text',
                          fontWeight: FontWeight.w700,
                          fontSize: 19.0,
                          letterSpacing: -0.49,
                          color: Color(0xFF34283E),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    GridView.builder(
                      padding: EdgeInsets.only(top: 0.0),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: 165,
                                  height: 165,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image:
                                            AssetImage(items[index]['image'])),
                                  ),
                                ),
                                Positioned(
                                  height: 36,
                                  width: 36,
                                  child: FavoriteButton(
                                      favoriteStatus: items[index]
                                          ['isFavorite']),
                                  bottom: -10,
                                  right: 8,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: List.generate(
                                  items[index]['rating'],
                                  (i) => Icon(
                                    Icons.star,
                                    color: Color(0xFFF2994A),
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              items[index]['title'].toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.15,
                                color: Color(0xFF34283E),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: items[index]['discount'] != 0
                                  ? Row(
                                      children: [
                                        Text(
                                          '\$${items[index]['price']}',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.41,
                                            color: Color(0xFFCE3E3E),
                                          ),
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                          '\$${items[index]['price']}',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.15,
                                            color: Color(0xFF9B9B9B),
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          '\$${items[index]['price']}',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.41,
                                            color: Color(0xFF34283E),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 17.0,
                        mainAxisSpacing: 17.0,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: items.length,
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: Color(0xFF663399),
                        strokeWidth: 5,
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: SizedBox(
          height: 87,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            iconSize: 24,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Catalogue',
                icon: Icon(Icons.apps),
              ),
              BottomNavigationBarItem(
                label: 'Favorite',
                icon: Icon(Icons.favorite_border),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.account_circle),
              ),
            ],
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedLabelStyle: TextStyle(
              color: Color(0xFF845FA1),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: TextStyle(
              color: Color(0xFF9B9B9B),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
            selectedItemColor: Color(0xFF845FA1),
            unselectedItemColor: Color(0xFF9B9B9B),
          ),
        ),
      ),
    );
  }
}
