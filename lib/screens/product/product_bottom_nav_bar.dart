import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_template/cubit/favorite/favorite_cubit.dart';
import 'package:e_commerce_template/cubit/product_page_options/product_page_options_cubit.dart';
import 'package:e_commerce_template/model/cart_item.dart';
import 'package:e_commerce_template/model/product.dart';
import 'package:e_commerce_template/screens/cart/cart_screen.dart';
import 'package:e_commerce_template/screens/product/rounded_fav_button48x48.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBottomNavBar extends StatelessWidget {
  final Product product;

  const ProductBottomNavBar({Key? key, required this.product})
      : super(key: key);

  void checkProductOptions(BuildContext context) {
    String selectedSize =
        context.read<ProductPageOptionsCubit>().getSelectedSize();

    String selectedColor =
        context.read<ProductPageOptionsCubit>().getSelectedColor();

    if (selectedSize == '' || selectedColor == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select all needed options'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    double discountPrice =
        (product.price * product.discount / 100).floor().toDouble();

    CartItem cartItem = CartItem(
      id: product.id,
      title: product.title,
      image: product.image,
      color: selectedColor,
      size: selectedSize,
      price: product.discount == 0 ? product.price : discountPrice,
      quantity: 1,
    );
    context.read<CartCubit>().addToCart(cartItem);
    Navigator.pushNamed(context, CartScreen.routeName);
  }

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
          color: Colors.white,
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
                  onPressed: () {
                    checkProductOptions(context);
                  },
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
        ),
      ),
    );
  }
}
