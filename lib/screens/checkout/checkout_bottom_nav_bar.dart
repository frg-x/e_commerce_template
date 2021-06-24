import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_template/cubit/delivery/delivery_cubit.dart';
import 'package:e_commerce_template/cubit/toggle_botnavbar/toggle_botnavbar_cubit.dart';
import 'package:e_commerce_template/screens/tabs_screen.dart';
import 'package:e_commerce_template/screens/verify_user_status_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutBottomNavBar extends StatefulWidget {
  @override
  _CheckoutBottomNavBarState createState() => _CheckoutBottomNavBarState();
}

class _CheckoutBottomNavBarState extends State<CheckoutBottomNavBar> {
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              height: 360,
              width: 327,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
              ),
              //alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 112,
                        ),
                        Positioned(
                          top: -198,
                          child: Container(
                            height: 310,
                            width: 310,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(155.0),
                              gradient: LinearGradient(
                                colors: AllColors.purpleGradient,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 24.0,
                          child:
                              SvgPicture.asset('assets/images/icons/check.svg'),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 16,
                      bottom: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Success',
                          style: AllStyles.SFProDisplay25w700deepPurple,
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Your order will be delivered soon.\nIt can be tracked in the \"Orders\" section.',
                          style: AllStyles.fontSize14w400lightPurpleGray,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.0),
                        SizedBox(
                          height: 48.0,
                          width: 239.0,
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<ToggleBotNavBarCubit>()
                                  .toggleBottomNavBarMenu(0);
                              Navigator.pushReplacementNamed(
                                  context, TabsScreen.routeName);
                              Future.delayed(Duration(seconds: 1)).then((_) {
                                context.read<CartCubit>().clearCart();
                                context
                                    .read<DeliveryCubit>()
                                    .clearDeliveryCost();
                              });
                            },
                            style: AllStyles.getStartedMainButtonStyle,
                            child: Text(
                              'Continue Shopping',
                              style: AllStyles.fontSize17w700white,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          'Go to Orders',
                          style: AllStyles.fontSize17w700lightGray,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 202.0,
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
              return BlocBuilder<DeliveryCubit, DeliveryState>(
                builder: (context, state) {
                  int deliveryCost = (state as DeliveryInitial).cost;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Items',
                            style: AllStyles.fontSize14w600lightGray,
                          ),
                          Text(
                            '\$${cartTotalSum.toStringAsFixed(2)}',
                            style: AllStyles.fontSize14w600lightGray,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery',
                            style: AllStyles.fontSize14w600lightGray,
                          ),
                          Text(
                            '\$$deliveryCost',
                            style: AllStyles.fontSize14w600lightGray,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total price',
                            style: AllStyles.fontSize19w700deepPurple,
                          ),
                          Text(
                            '\$${(cartTotalSum + deliveryCost).toStringAsFixed(2)}',
                            style: AllStyles.fontSize19w700deepPurple,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 48.0,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: deliveryCost != 0
                              ? () {
                                  showSuccessDialog(context);
                                }
                              : null,
                          child: Text(
                            'Pay',
                            style: AllStyles.fontSize17w700white,
                          ),
                          style: ButtonStyle(
                            backgroundColor: deliveryCost != 0
                                ? MaterialStateProperty.all<Color>(
                                    AllColors.mainYellow,
                                  )
                                : MaterialStateProperty.all<Color>(
                                    AllColors.lightGray),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
