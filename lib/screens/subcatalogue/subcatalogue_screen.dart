import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/products/products_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/model/product.dart';
import 'package:e_commerce_template/widgets/favorite_button.dart';
import 'package:e_commerce_template/screens/product/product_screen.dart';
import 'package:e_commerce_template/screens/subcatalogue/subcatalogue_appbar.dart';
import 'package:e_commerce_template/widgets/custom_sliver_grid_delegate.dart';
import 'package:e_commerce_template/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCatalogueScreen extends StatefulWidget {
  static const routeName = '/subcatalogue';

  @override
  _SubCatalogueScreenState createState() => _SubCatalogueScreenState();
}

class _SubCatalogueScreenState extends State<SubCatalogueScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> subCatInfo =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return BlocBuilder<ToggleBotNavBarCubit, ToggleBotNavBarState>(
      builder: (context, innerState) {
        if (innerState is GetSelectedIndex) {
          return Scaffold(
            appBar: SubCatalogueAppBar(title: subCatInfo['title']),
            backgroundColor: AllColors.tabsScreenBgColor,
            extendBody: true,
            body: SubCatBody(pageInfo: subCatInfo),
          );
        } else
          return Container();
      },
    );
  }
}

class SubCatBody extends StatefulWidget {
  final Map<String, dynamic> pageInfo;
  SubCatBody({required this.pageInfo});

  @override
  _SubCatBodyState createState() => _SubCatBodyState();
}

class _SubCatBodyState extends State<SubCatBody> {
  List<Map<String, dynamic>> clothesTypes = [
    {'title': 'All', 'isActive': false},
    {'title': 'Dresses', 'isActive': false},
    {'title': 'Tops', 'isActive': false},
    {'title': 'Sweaters', 'isActive': false},
    {'title': 'Jeans', 'isActive': false},
    {'title': 'Skirts', 'isActive': false},
    {'title': 'Hats', 'isActive': false},
  ];

  void toggleClothesType(int index) {
    setState(() {
      clothesTypes[index]['isActive'] = !clothesTypes[index]['isActive'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, GetProductsState>(
        builder: (context, state) {
//print(state);
      if (state is GetProductsInitial) {
        return Container();
      } else if (state is GetProductsLoading) {
        return LoadingIndicator(height: 165.0);
      } else if (state is GetProductsLoaded) {
        List<Product> productItemList = state.products
            .where((item) => item.inCategories.contains(widget.pageInfo['id']))
            .toList();
        return Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 36.0),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 26.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: clothesTypes.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 8.0);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => toggleClothesType(index),
                        overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                            color: clothesTypes[index]['isActive']
                                ? AllColors.mainYellow
                                : Colors.white,
                          ),
                          child: Text(
                            clothesTypes[index]['title'],
                            style: clothesTypes[index]['isActive']
                                ? AllStyles.fontSize13w500
                                    .copyWith(color: Colors.white)
                                : AllStyles.fontSize13w500
                                    .copyWith(color: AllColors.lightPurpleGray),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${productItemList.length} items'
                        /*'166 items'*/,
                        style: AllStyles.fontSize19w700deepPurple,
                      ),
                      Row(
                        children: [
                          Text(
                            'Sort by: ',
                            style: AllStyles.fontSize12w700lightGray,
                          ),
                          Text(
                            'Featured',
                            style: AllStyles.fontSize12w700deepPurple,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ]),
              ),
              Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductScreen.routeName,
                            arguments: productItemList[index].id,
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
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          productItemList[index].image),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  height: 36,
                                  width: 36,
                                  child: context.read<FavoriteCubit>().isLogged
                                      ? StreamBuilder<dynamic>(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(context
                                                  .read<FavoriteCubit>()
                                                  .userId)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              var favProducts =
                                                  snapshot.data['favProducts'];
                                              return FavoriteButton(
                                                favoriteStatus:
                                                    favProducts.contains(
                                                            productItemList[
                                                                    index]
                                                                .id)
                                                        ? true
                                                        : false,
                                                product: productItemList[index],
                                              );
                                            } else
                                              return Icon(Icons.error_outline,
                                                  color: Colors.grey[400]);
                                          },
                                        )
                                      : Container(),
                                  bottom: -10,
                                  right: 8,
                                ),
                                productItemList[index].discount != 0
                                    ? Positioned(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40.0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                            ),
                                            gradient: LinearGradient(
                                              transform:
                                                  GradientRotation(72 / 360),
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: AllColors
                                                  .discountLabelGradientColors,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '-${productItemList[index].discount.toStringAsFixed(0)}%',
                                              style:
                                                  AllStyles.fontSize11w700white,
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: List.generate(
                                  productItemList[index].rating,
                                  (i) => Icon(
                                    Icons.star,
                                    color: AllColors.ratingStarColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              productItemList[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AllStyles.fontSize14w400.copyWith(
                                letterSpacing: -0.15,
                                color: AllColors.deepPurple,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: productItemList[index].discount != 0
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$${((productItemList[index].price * productItemList[index].discount / 100)).floor().toStringAsFixed(0)}',
                                          maxLines: 1,
                                          style: AllStyles
                                              .discountPriceLabelTextStyle,
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                          '\$${productItemList[index].price}',
                                          maxLines: 1,
                                          style:
                                              AllStyles.oldPriceLabelTextStyle,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          '\$${productItemList[index].price}',
                                          maxLines: 1,
                                          style: AllStyles
                                              .fontSize17w700deepPurple,
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      crossAxisCount: 2,
                      crossAxisSpacing: 17.0,
                      mainAxisSpacing: 17.0,
                      height: 265,
                    ),
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   crossAxisCount: 2,
//   crossAxisSpacing: 17.0,
//   mainAxisSpacing: 17.0,
//   childAspectRatio: 0.65,
// ),
                    itemCount: productItemList.length /*productItemList.length*/
                    ),
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
