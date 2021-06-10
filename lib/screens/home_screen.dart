import 'package:e_commerce_template/dummy_data.dart';
import 'package:e_commerce_template/screens/favorite_button.dart';
import 'package:e_commerce_template/widgets/advertisement_card.dart';
import 'package:e_commerce_template/widgets/catalogue_item.dart';
import 'package:e_commerce_template/widgets/progress_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String? uid;
  PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  int _lastIndex = 0;
  late AnimationController _animationController;

  List<bool> animationStatus = [
    false,
    false,
    false,
    false,
    false,
  ];

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
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      animationStatus[0] = true;
    });

    _animationController = new AnimationController(
        vsync: this,
        duration: Duration(
          seconds: autoScrollDuration,
        ));

    _animationController.addListener(
      () {
        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reset();
          final int page = 4;
          _lastIndex = _selectedIndex;
          _selectedIndex++;
          if (_selectedIndex <= page && _selectedIndex > 0) {
            setState(() {
              animationStatus[_selectedIndex] = true;
            });
            _pageController.animateToPage(_selectedIndex,
                duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          } else {
            for (int i = 0; i <= 4; i++) {
              setState(() {
                animationStatus[i] = false;
              });
            }
            _lastIndex = _selectedIndex;
            _selectedIndex = 0;
            _pageController.animateToPage(_selectedIndex,
                duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          }
        }
      },
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // print('Selected index: $_selectedIndex');
    // print('Last index: $_lastIndex');
    // print(animationStatus);
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 36.0,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 98.0,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: PageView.builder(
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          return AdvertisementCard(
                            title: progressItemList[index].title,
                            image: progressItemList[index].bgImage,
                          );
                        },
                        onPageChanged: (_) {
                          _animationController.forward();
                          setState(() {
                            if (_lastIndex == 5 && !animationStatus[0])
                              animationStatus[0] = true;
                          });
                        },
                        itemCount: progressItemList.length,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (final animation in animationStatus)
                              ProgressItemWidget(animationStatus: animation)
                          ],
                          //_selectedIndex
                        ),
                      ),
                    ),
                  ),
                ],
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
              SizedBox(height: 18.0),
              Container(
                height: 92.0,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  itemCount: categoryItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                primary: false,
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
                                  image: AssetImage(items[index]['image'])),
                            ),
                          ),
                          Positioned(
                            height: 36,
                            width: 36,
                            child: FavoriteButton(
                              favoriteStatus: items[index]['isFavorite'],
                            ),
                            bottom: -10,
                            right: 8,
                          ),
                          items[index]['discount'] != 0
                              ? Positioned(
                                  // height: 36,
                                  // width: 36,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40.0),
                                        bottomRight: Radius.circular(40.0),
                                      ),
                                      gradient: LinearGradient(
                                        transform: GradientRotation(72 / 360),
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFFD23A3A),
                                          Color(0xFFF49763),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '-${items[index]['discount']}%',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    width: 47.0,
                                    height: 20.0,
                                  ),
                                  top: 8,
                                  left: 0,
                                )
                              : Container(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: items[index]['discount'] != 0
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${((items[index]['price'] * items[index]['discount'] / 100) as double).floor().toStringAsFixed(0)}',
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
                                      decoration: TextDecoration.lineThrough,
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
                  childAspectRatio: 0.55,
                ),
                itemCount: items.length,
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Color(0xFF663399),
                  strokeWidth: 5,
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
