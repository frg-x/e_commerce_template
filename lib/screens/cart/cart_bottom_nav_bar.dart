import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_template/screens/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBottomNavBar extends StatefulWidget {
  @override
  _CartBottomNavBarState createState() => _CartBottomNavBarState();
}

class _CartBottomNavBarState extends State<CartBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 139.0,
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
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 18.0),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (BuildContext context, state) {
              double cartTotalSum = (state as CartInitial).cartSum;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total price',
                        style: AllStyles.fontSize19w700deepPurple,
                      ),
                      Text(
                        '\$${cartTotalSum.toStringAsFixed(2)}',
                        style: AllStyles.fontSize19w700deepPurple,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 48.0,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: cartTotalSum == 0
                          ? null
                          : () {
                              Navigator.pushNamed(
                                  context, CheckoutScreen.routeName);
                            },
                      child: Text(
                        'Check Out',
                        style: AllStyles.fontSize17w700white,
                      ),
                      style: ButtonStyle(
                        backgroundColor: cartTotalSum != 0
                            ? MaterialStateProperty.all<Color>(
                                AllColors.mainYellow,
                              )
                            : MaterialStateProperty.all<Color>(
                                AllColors.lightGray),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
