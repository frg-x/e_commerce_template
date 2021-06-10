import 'package:e_commerce_template/widgets/my_app_bar.dart';
import 'package:e_commerce_template/widgets/my_bottom_nav_bar.dart';
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
        child: Center(child: Text('Catalogue')),
      ),
      'appBar': AppBar(title: Text('Catalogue')),
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

  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _tabPages[_selectedIndex]['appBar'],
      backgroundColor: Color(0xFFE5E5E5),
      extendBody: true,
      body: _tabPages[_selectedIndex]['body'],
      bottomNavigationBar: MyBottomNavBar(_selectPage),
    );
  }
}
