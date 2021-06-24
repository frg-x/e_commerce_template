import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/widgets/favorite_button.dart';
import 'package:e_commerce_template/screens/product/product_screen.dart';
import 'package:e_commerce_template/widgets/custom_sliver_grid_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, GetFavoriteState>(
        builder: (context, state) {
      var favProducts = (state as GetFavoriteLoaded).favoriteProducts;
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 24.0,
              bottom: 16.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${favProducts.length} items',
                  style: AllStyles.fontSize19w700deepPurple,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Sort by: ', style: AllStyles.fontSize12w700lightGray),
                    Text('Price: lowest to high ',
                        style: AllStyles.fontSize12w700deepPurple),
                    SvgPicture.asset('assets/images/icons/chevron-right-2.svg'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: (favProducts.length > 0 &&
                    context.read<FavoriteCubit>().isLogged)
                ? GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductScreen.routeName,
                            arguments: favProducts[index].id,
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
                                      image:
                                          AssetImage(favProducts[index].image),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  height: 36,
                                  width: 36,
                                  child: FavoriteButton(
                                    product: favProducts[index],
                                    favoriteStatus: true,
                                  ),
                                  bottom: -10,
                                  right: 8,
                                ),
                                favProducts[index].discount != 0
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
                                              '-${favProducts[index].discount.toStringAsFixed(0)}%',
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
                                  favProducts[index].rating,
                                  (i) => Icon(
                                    Icons.star,
                                    color: AllColors.ratingStarColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              favProducts[index].title,
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
                              child: favProducts[index].discount != 0
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$${((favProducts[index].price * favProducts[index].discount / 100)).floor().toStringAsFixed(0)}',
                                          maxLines: 1,
                                          style: AllStyles
                                              .discountPriceLabelTextStyle,
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                          '\$${favProducts[index].price}',
                                          maxLines: 1,
                                          style:
                                              AllStyles.oldPriceLabelTextStyle,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          '\$${favProducts[index].price}',
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
                    itemCount: favProducts.length)
                : Center(
                    child: Text(
                      'You have no favorite products.\nTry to add them)',
                      style: AllStyles.fontSize14w400lightPurpleGray,
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        ],
      );
    });
  }
}
