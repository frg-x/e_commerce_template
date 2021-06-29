import 'dart:ui';
import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_template/model/cart_item.dart';
import 'package:e_commerce_template/screens/cart/cart_appbar.dart';
import 'package:e_commerce_template/screens/cart/cart_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CartAppBar(),
      extendBody: true,
      body: CartScreenBody(),
      backgroundColor: AllColors.tabsScreenBgColor,
      bottomNavigationBar: CartBottomNavBar(),
    );
  }
}

class CartScreenBody extends StatefulWidget {
  @override
  _CartScreenBodyState createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        //print(state);
        //context.read<CartCubit>().echoCart();
        List<CartItem> cart = (state as CartInitial).cart;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: cart.length,
          itemBuilder: (context, int index) {
            return Container(
              height: 117.0,
              padding: EdgeInsets.all(16.0),
              decoration: index == cart.length - 1
                  ? BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: AllColors.deepPurple.withOpacity(0.08),
                            blurRadius: 12.0,
                            offset: Offset(0.0, 4.0)),
                      ],
                      color: Colors.white,
                    )
                  : BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: AllColors.dividerBetweenCartItems,
                          width: 1.0,
                        ),
                      ),
                    ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      cart[index].image,
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    width: 80.0,
                    height: 80.0,
                  ),
                  const SizedBox(width: 12.0),
                  Container(
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${cart[index].title}',
                            style: AllStyles.fontSize14w400deepPurple,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                'Color: ',
                                style: AllStyles.fontSize14w600
                                    .copyWith(color: AllColors.lightGray),
                              ),
                              Text(
                                '${cart[index].color}, ',
                                style: AllStyles.fontSize14w400deepPurple,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Size: ',
                                style: AllStyles.fontSize14w600
                                    .copyWith(color: AllColors.lightGray),
                              ),
                              Text(
                                '${cart[index].size}',
                                style: AllStyles.fontSize14w400deepPurple,
                              ),
                            ],
                          ),
                          Text(
                            '\$${cart[index].price}',
                            style: AllStyles.fontSize17w700deepPurple,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset(
                            'assets/images/icons/circle_plus_icon.svg',
                            height: 24,
                            width: 24,
                          ),
                          onTap: () =>
                              context.read<CartCubit>().increment(cart[index]),
                        ),
                        Text(
                          cart[index].quantity.toStringAsFixed(0),
                          style: AllStyles.fontSize14w400lightPurpleGray,
                        ),
                        GestureDetector(
                          child: SvgPicture.asset(
                            'assets/images/icons/circle_minus_icon.svg',
                            height: 24,
                            width: 24,
                          ),
                          onTap: () =>
                              context.read<CartCubit>().decrement(cart[index]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
