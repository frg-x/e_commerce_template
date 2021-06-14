import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/ads_cubit.dart';
import 'package:e_commerce_template/widgets/catalogue_carousel.dart';
import 'package:e_commerce_template/widgets/featured_products.dart';
import 'package:e_commerce_template/widgets/loading_indicator.dart';
import 'package:e_commerce_template/widgets/advertisement_card.dart';
import 'package:e_commerce_template/widgets/progress_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String? uid;
  User? loggedInUser = FirebaseAuth.instance.currentUser;
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
    //print(uid);
    //print('LOGGED: $loggedInUser');
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

    if (loggedInUser?.uid != null) {
      //createNewUser();
      this.uid = loggedInUser?.uid;
    }

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
              BlocConsumer<AdsCubit, GetAdsState>(
                listener: (context, state) {
                  if (state is GetAdsError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is GetAdsLoading) {
                    return LoadingIndicator(height: 98.0);
                  } else if (state is GetAdsLoaded) {
                    final ads = state.ads;
                    return Stack(
                      children: [
                        Container(
                          height: 98.0,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: PageView.builder(
                              controller: _pageController,
                              itemBuilder: (context, index) {
                                return AdvertisementCard(
                                  title: ads[index].title,
                                  image: ads[index].image,
                                );
                              },
                              onPageChanged: (_) {
                                _animationController.forward();
                                setState(() {
                                  if (_lastIndex == 5 && !animationStatus[0])
                                    animationStatus[0] = true;
                                });
                              },
                              itemCount: 5,
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
                                    ProgressItemWidget(
                                        animationStatus: animation)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
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
                      style: AllStyles.homeCatTitleTextStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          'See All',
                          style: AllStyles.SFProText12w700lightGray,
                        ),
                        SizedBox(width: 2.0),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 14.0,
                          color: AllColors.lightGray,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.0),
              CatalogueCarousel(),
              SizedBox(height: 32.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Featured',
                  style: AllStyles.homeCatTitleTextStyle,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              FeaturedProducts(),
              SizedBox(height: 30),
              LoadingIndicator(height: 40.0),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
