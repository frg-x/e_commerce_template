import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/products/products_cubit.dart';
import 'package:e_commerce_template/model/product.dart';
import 'package:e_commerce_template/widgets/favorite_button.dart';
import 'package:e_commerce_template/screens/product/product_screen.dart';
import 'package:e_commerce_template/widgets/custom_sliver_grid_delegate.dart';
import 'package:e_commerce_template/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedProducts extends StatefulWidget {
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    //print(context.read<FavoriteCubit>().isLogged);
    return BlocBuilder<ProductsCubit, GetProductsState>(
        builder: (context, state) {
      //print(state);
      if (state is GetProductsInitial) {
        return Container();
      } else if (state is GetProductsLoading) {
        return LoadingIndicator(height: 165.0);
      } else if (state is GetProductsLoaded) {
        List<Product> productItemList = state.products;
        //List<String> favProducts = context.read<FavoriteCubit>().favProducts;
        //print(productItemList);
        return GridView.builder(
            padding: EdgeInsets.only(top: 0.0),
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
                              image: AssetImage(productItemList[index].image),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 36,
                          width: 36,
                          child: context.read<FavoriteCubit>().isLogged
                              // ? BlocBuilder<FavoriteCubit, GetFavoriteState>(
                              //     builder: (context, state) {
                              //       if (state is GetFavoriteLoaded) {
                              //         return FavoriteButton(
                              //           favoriteStatus: state.favoriteList
                              //               .contains(
                              //                   productItemList[index].id),
                              //           productId: productItemList[index].id,
                              //         );
                              //       } else {
                              //         return CircularProgressIndicator();
                              //       }
                              //     },
                              //   )
                              ? StreamBuilder<dynamic>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(context.read<FavoriteCubit>().userId)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var favProducts =
                                          snapshot.data['favProducts'];
                                      return FavoriteButton(
                                        favoriteStatus: favProducts.contains(
                                                productItemList[index].id)
                                            ? true
                                            : false,
                                        productId: productItemList[index].id,
                                      );
                                    } else
                                      return FavoriteButton(
                                        favoriteStatus: false,
                                        productId: productItemList[index].id,
                                      );
                                  },
                                )
                              : Container(),
                          bottom: -10,
                          right: 8,
                        ),
                        productItemList[index].discount != 0
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
                                      colors:
                                          AllColors.discountLabelGradientColors,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '-${productItemList[index].discount.toStringAsFixed(0)}%',
                                      style: AllStyles.fontSize11w700white,
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
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: productItemList[index].discount != 0
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${((productItemList[index].price * productItemList[index].discount / 100)).floor().toStringAsFixed(0)}',
                                  maxLines: 1,
                                  style: AllStyles.discountPriceLabelTextStyle,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  '\$${productItemList[index].price}',
                                  maxLines: 1,
                                  style: AllStyles.oldPriceLabelTextStyle,
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Text(
                                  '\$${productItemList[index].price}',
                                  maxLines: 1,
                                  style: AllStyles.fontSize17w700deepPurple,
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
            itemCount: 4 /*productItemList.length*/
            );
      } else {
        return Container();
      }
    });
  }
}