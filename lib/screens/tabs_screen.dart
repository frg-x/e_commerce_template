import 'package:e_commerce_template/widgets/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _tabPages = [
    {
      'body': HomeScreen(),
      'appBar': MyAppBar(),
    },
    {
      'body': Container(
        child: Text('Catalogue'),
      ),
      'appBar': Container(),
    },
    {
      'body': Container(
        child: Text('Favorite'),
      ),
      'appBar': Container(),
    },
    {
      'body': Container(
        child: Text('Profile'),
      ),
      'appBar': Container(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _tabPages[0]['appBar'],
      backgroundColor: Color(0xFFE5E5E5),
      extendBody: true,
      body: _tabPages[0]['body'],
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  late bool isCartOpened;
  late double cartOffset;
  late double bottomIconsOffset;
  int _activeTab = 0;

  void _selectPage(int index) {
    setState(() {
      _activeTab = index;
    });
  }

  void slideCart() {
    if (isCartOpened) {
      setState(() {
        cartOffset = 0;
        bottomIconsOffset = 85;
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
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 19.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavButton(
                    title: 'Home',
                    image: _activeTab == 0
                        ? 'assets/images/icons/home_icon_active.png'
                        : 'assets/images/icons/home_icon.png',
                    color: _activeTab == 0
                        ? Color(0xFF40304D)
                        : Color(0xFF9Ba9B9B),
                    onPress: () => _selectPage(0),
                  ),
                  BottomNavButton(
                    title: 'Catalogue',
                    image: _activeTab == 1
                        ? 'assets/images/icons/cat_icon_active.png'
                        : 'assets/images/icons/cat_icon.png',
                    color:
                        _activeTab == 1 ? Color(0xFF40304D) : Color(0xFF9B9B9B),
                    onPress: () => _selectPage(1),
                  ),
                  BottomNavButton(
                    title: 'Favorite',
                    image: _activeTab == 2
                        ? 'assets/images/icons/fav_icon_active.png'
                        : 'assets/images/icons/fav_icon.png',
                    color:
                        _activeTab == 2 ? Color(0xFF40304D) : Color(0xFF9B9B9B),
                    onPress: () => _selectPage(2),
                  ),
                  BottomNavButton(
                    title: 'Profile',
                    image: _activeTab == 3
                        ? 'assets/images/icons/profile_icon_active.png'
                        : 'assets/images/icons/profile_icon.png',
                    color:
                        _activeTab == 3 ? Color(0xFF40304D) : Color(0xFF9B9B9B),
                    onPress: () => _selectPage(3),
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80.0),
                bottomLeft: Radius.circular(80.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF34283E),
                  Color(0xFF845FA1),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                transform: GradientRotation(263 / 360),
              ),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: slideCart,
                    child: Material(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        child: Ink.image(
                          image:
                              AssetImage('assets/images/icons/cart_icon.png'),
                          fit: BoxFit.scaleDown,
                          width: 36.0,
                          height: 36.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$239.98',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.07,
                        ),
                      ),
                      Text(
                        '2 items',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.07,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomNavButton extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final Function()? onPress;

  BottomNavButton({
    required this.title,
    required this.image,
    required this.onPress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Ink.image(
              image: AssetImage(image),
              fit: BoxFit.scaleDown,
              width: 36.0,
              height: 36.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 0.07,
                color: color,
                height: 0.85,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
