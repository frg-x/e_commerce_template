import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/product_page_options/product_page_options_cubit.dart';
import 'package:e_commerce_template/cubit/products/products_cubit.dart';
import 'package:e_commerce_template/model/product.dart';
import 'package:e_commerce_template/screens/product/product_bottom_nav_bar.dart';
import 'package:e_commerce_template/widgets/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      extendBody: true,
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
  void initState() {
    context.read<ProductPageOptionsCubit>().clearOptions();
    context.read<ProductPageOptionsCubit>().colorsList =
        widget.product.colors.map((e) {
      return {
        'id': e['id'],
        'image': e['image'],
        'title': e['title'],
        'isActive': false,
      };
    }).toList();

    context.read<ProductPageOptionsCubit>().sizesList =
        widget.product.sizes.map((e) {
      return {
        'id': e['id'],
        'title': e['title'],
        'isActive': false,
      };
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List bigPhotos = widget.product.bigPhotos;
    List<Image> bigPhotosImages = [];
    bigPhotos.forEach((photo) {
      bigPhotosImages.add(Image.asset(photo, fit: BoxFit.contain));
    });

    Map<String, dynamic> selectedColor;
    Map<String, dynamic> selectedSize;

    List<Map<String, dynamic>> colorsList =
        context.read<ProductPageOptionsCubit>().colorsList;
    List<Map<String, dynamic>> sizesList =
        context.read<ProductPageOptionsCubit>().sizesList;

    void selectColor(int index) {
      setState(() {
        for (int i = 0; i < colorsList.length; i++) {
          colorsList[i]['isActive'] = false;
        }
        colorsList[index]['isActive'] = true;
        selectedColor = colorsList[index];
        //print(selectedColor);
      });
    }

    void selectSize(int index) {
      setState(() {
        for (int i = 0; i < sizesList.length; i++) {
          sizesList[i]['isActive'] = false;
        }
        sizesList[index]['isActive'] = true;
        selectedSize = sizesList[index];
        //print(selectedSize);
      });
    }

    var relatedProducts = context
        .read<ProductsCubit>()
        .allProducts
        .where((element) => element.id != widget.product.id)
        .toList();

    return SingleChildScrollView(
      child: Column(
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
                      return bigPhotosImages[index];
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
                    itemCount: bigPhotosImages.length,
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
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: AllColors.deepPurple.withOpacity(0.08),
                  offset: Offset(0, 4.0),
                  blurRadius: 12.0,
                ),
              ],
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
                Container(
                  padding: EdgeInsets.only(top: 12.0),
                  alignment: Alignment.bottomLeft,
                  child: widget.product.discount != 0
                      ? Row(
                          children: [
                            Text(
                              '\$${(widget.product.price * widget.product.discount / 100).floor().toStringAsFixed(2)}',
                              style: AllStyles.discountPriceLabelTextStyle
                                  .copyWith(fontSize: 25.0),
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              '\$${widget.product.price.toStringAsFixed(2)}',
                              style: AllStyles.oldPriceLabelTextStyle.copyWith(
                                fontSize: 21.0,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: AllStyles.SFProDisplay25w700.copyWith(
                            color: AllColors.deepPurple,
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 12.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Colors',
                    style: AllStyles.fontSize14w600
                        .copyWith(color: AllColors.lightGray),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int index = 0; index < colorsList.length; index++)
                        GestureDetector(
                          onTap: () => selectColor(index),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 47,
                                height: 47,
                                child: Container(
                                  decoration: colorsList[index]['isActive']
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                          border: Border.all(
                                            width: 2.0,
                                            color: AllColors.mainYellow,
                                          ),
                                        )
                                      : BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                          border: Border.all(
                                            width: 2.0,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                  child: Image.asset(
                                    colorsList[index]['image'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                  child: Text(
                    'Sizes',
                    style: AllStyles.fontSize14w600
                        .copyWith(color: AllColors.lightGray),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int index = 0; index < sizesList.length; index++)
                        GestureDetector(
                          onTap: () => selectSize(index),
                          child: SizedBox(
                            width: 47,
                            height: 47,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: sizesList[index]['isActive']
                                      ? AllColors.mainYellow
                                      : AllColors.phoneNumTextFieldBorder,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                color: sizesList[index]['isActive']
                                    ? AllColors.mainYellow
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  widget.product.sizes[index]['title'],
                                  style: sizesList[index]['isActive']
                                      ? AllStyles.fontSize14w400white
                                      : AllStyles.fontSize14w400lightPurpleGray,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AllColors.deepPurple.withOpacity(0.08),
                  offset: Offset(0, 4.0),
                  blurRadius: 12.0,
                ),
              ],
            ),
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 24.0,
              bottom: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product details',
                  style: AllStyles.fontSize19w700deepPurple,
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.product.description,
                  style: AllStyles.fontSize14w400lightPurpleGray,
                ),
                SizedBox(height: 12.0),
                Center(
                  child: SvgPicture.asset(
                      'assets/images/icons/product_arrow_down.svg'),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AllColors.deepPurple.withOpacity(0.08),
                  offset: Offset(0, 4.0),
                  blurRadius: 12.0,
                ),
              ],
            ),
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 24.0,
              bottom: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reviews',
                      style: AllStyles.fontSize19w700deepPurple,
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
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Olha Chabanova',
                  style: AllStyles.fontSize14w600
                      .copyWith(color: AllColors.deepPurple),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: List.generate(
                        widget.product.rating,
                        (i) => Icon(
                          Icons.star,
                          color: AllColors.ratingStarColor,
                          size: 15,
                        ),
                      ),
                    ),
                    Text(
                      'June 5, 2021',
                      style: AllStyles.fontSize12w400lightPurpleGray,
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  widget.product.reviews,
                  style: AllStyles.fontSize14w400lightPurpleGray,
                ),
                SizedBox(height: 14.0),
                Text(
                  '835 people found this helpful',
                  style: AllStyles.fontSize11w400white,
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 24.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Comment',
                        style: AllStyles.fontSize14w400.copyWith(
                          color: AllColors.deepPurple,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Helpful',
                              style: AllStyles.fontSize12w400lightGray,
                            ),
                          ),
                          SizedBox(width: 6.0),
                          SizedBox(
                            child: SvgPicture.asset(
                                'assets/images/icons/thumb_up.svg'),
                            height: 24.0,
                            width: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 32.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Products related to this item',
                    style: AllStyles.fontSize19w700deepPurple,
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  height: 410.0,
                  padding: EdgeInsets.only(top: 16.0),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 16.0),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int index) {
                      return Row(
                        children: [
                          Container(
                            width: 165,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ProductScreen.routeName,
                                  arguments: relatedProducts[index].id,
                                );
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        width: 165,
                                        height: 165,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                relatedProducts[index].image),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        height: 36,
                                        width: 36,
                                        child: context
                                                .read<FavoriteCubit>()
                                                .isLogged
                                            ? StreamBuilder<dynamic>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(context
                                                        .read<FavoriteCubit>()
                                                        .userId)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    var favProducts = snapshot
                                                        .data['favProducts'];
                                                    return FavoriteButton(
                                                      favoriteStatus:
                                                          favProducts.contains(
                                                                  relatedProducts[
                                                                          index]
                                                                      .id)
                                                              ? true
                                                              : false,
                                                      productId:
                                                          relatedProducts[index]
                                                              .id,
                                                    );
                                                  } else
                                                    return FavoriteButton(
                                                      favoriteStatus: false,
                                                      productId:
                                                          relatedProducts[index]
                                                              .id,
                                                    );
                                                },
                                              )
                                            : Container(),
                                        bottom: -10,
                                        right: 8,
                                      ),
                                      relatedProducts[index].discount != 0
                                          ? Positioned(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40.0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                  ),
                                                  gradient: LinearGradient(
                                                    transform: GradientRotation(
                                                        72 / 360),
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: AllColors
                                                        .discountLabelGradientColors,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '-${relatedProducts[index].discount.toStringAsFixed(0)}%',
                                                    style: AllStyles
                                                        .fontSize11w700white,
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: List.generate(
                                        relatedProducts[index].rating,
                                        (i) => Icon(
                                          Icons.star,
                                          color: AllColors.ratingStarColor,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    relatedProducts[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AllStyles.fontSize14w400.copyWith(
                                      letterSpacing: -0.15,
                                      color: AllColors.deepPurple,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: relatedProducts[index].discount != 0
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '\$${((relatedProducts[index].price * relatedProducts[index].discount / 100)).floor().toStringAsFixed(2)}',
                                                maxLines: 1,
                                                style: AllStyles
                                                    .discountPriceLabelTextStyle,
                                              ),
                                              SizedBox(width: 4.0),
                                              Text(
                                                '\$${relatedProducts[index].price.toStringAsFixed(2)}',
                                                maxLines: 1,
                                                style: AllStyles
                                                    .oldPriceLabelTextStyle,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                '\$${relatedProducts[index].price.toStringAsFixed(2)}',
                                                maxLines: 1,
                                                style: AllStyles
                                                    .fontSize17w700deepPurple,
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                        ],
                      );
                    },
                    itemCount: 5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
