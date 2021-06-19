import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/products/products_cubit.dart';
import 'package:e_commerce_template/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_svg/svg.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = context
        .read<ProductsCubit>()
        .allProducts
        .firstWhere((product) => product.id == productId);
    return Scaffold(
      body: ProductScreenBody(product: product),
      backgroundColor: AllColors.tabsScreenBgColor,
      bottomNavigationBar: ProductBottomNavBar(product: product),
    );
  }
}

class ProductScreenBody extends StatefulWidget {
  final Product product;

  ProductScreenBody({required this.product});

  @override
  _ProductScreenBodyState createState() => _ProductScreenBodyState();
}

class _ProductScreenBodyState extends State<ProductScreenBody> {
  @override
  Widget build(BuildContext context) {
    List<Image> bigPhotos = [
      Image.asset(widget.product.bigPhotos[0], fit: BoxFit.fill),
      Image.asset(widget.product.bigPhotos[1], fit: BoxFit.fill),
      Image.asset(widget.product.bigPhotos[2], fit: BoxFit.fill),
    ];

    return Column(
      children: [
        Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CarouselSlider.builder(
                  unlimitedMode: true,
                  slideBuilder: (index) {
                    return bigPhotos[index];
                  },
                  slideTransform: DefaultTransform(),
                  slideIndicator: CircularSlideIndicator(
                    padding: EdgeInsets.only(bottom: 8.0),
                    currentIndicatorColor: Colors.white,
                    itemSpacing: 11.0,
                    indicatorRadius: 4.0,
                    indicatorBackgroundColor: Colors.white.withAlpha(100),
                    alignment: Alignment.bottomCenter,
                  ),
                  itemCount: bigPhotos.length,
                ),
              ),
              Container(
                height: 44.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AllColors.productPageGradientColor.withOpacity(0.37),
                      AllColors.productPageGradientColor.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 12.0,
            bottom: 24.0,
            left: 16.0,
            right: 16.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: List.generate(
                          widget.product.rating,
                          (i) => Icon(
                            Icons.star,
                            color: AllColors.ratingStarColor,
                            size: 17,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        '8 reviews',
                        style: AllStyles.fontSize12w700lightPurpleGray,
                      ),
                    ],
                  ),
                  Text('In Stock', style: AllStyles.fontSize12w700green),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  widget.product.title,
                  style: AllStyles.fontSize19w400deepPurple,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductBottomNavBar extends StatelessWidget {
  final Product product;

  const ProductBottomNavBar({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(5.0, 0),
            blurRadius: 15.0,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 48.0,
                width: 48.0,
                child: TextButton(
                  child: SvgPicture.asset(
                      'assets/images/icons/arrow_left_gray.svg'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: AllStyles.roundedButton8px48x48,
                ),
              ),
              SizedBox(
                height: 48.0,
                width: 239.0,
                child: TextButton(
                  onPressed: () {},
                  style: AllStyles.getStartedMainButtonStyle,
                  child: Text(
                    'Add to Cart',
                    style: AllStyles.fontSize17w700white,
                  ),
                ),
              ),
              context.read<FavoriteCubit>().isLogged
                  ? StreamBuilder<dynamic>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(context.read<FavoriteCubit>().userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var favProducts = snapshot.data['favProducts'];
                          return RoundedFavoriteButton48x48(
                            favoriteStatus:
                                favProducts.contains(product.id) ? true : false,
                            productId: product.id,
                          );
                        } else
                          return Icon(Icons.error_outline,
                              color: Colors.grey[400]);
                      },
                    )
                  : Container(),
            ],
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}

class RoundedFavoriteButton48x48 extends StatelessWidget {
  final bool favoriteStatus;
  final String productId;

  RoundedFavoriteButton48x48({
    required this.favoriteStatus,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      width: 48.0,
      child: TextButton(
        child: favoriteStatus
            ? Icon(
                Icons.favorite,
                size: 26,
                color: AllColors.mainYellow,
              )
            : ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return ui.Gradient.linear(
                    Offset(0, 20),
                    Offset(12, 8),
                    AllColors.purpleGradient,
                  );
                },
                child: Icon(
                  Icons.favorite_border_outlined,
                  size: 26,
                ),
              ),
        onPressed: () {
          context.read<FavoriteCubit>().toggleFavorite(productId);
        },
        style: AllStyles.roundedButton8px48x48,
      ),
    );
  }
}
