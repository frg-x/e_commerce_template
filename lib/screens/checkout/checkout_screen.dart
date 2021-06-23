import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/cubit/delivery/delivery_cubit.dart';
import 'package:e_commerce_template/screens/checkout/checkout_appbar.dart';
import 'package:e_commerce_template/screens/checkout/checkout_bottom_nav_bar.dart';
import 'package:e_commerce_template/screens/checkout/gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar(),
      extendBody: true,
      body: CheckoutScreenBody(),
      backgroundColor: AllColors.tabsScreenBgColor,
      bottomNavigationBar: CheckoutBottomNavBar(),
    );
  }
}

class CheckoutScreenBody extends StatefulWidget {
  @override
  _CheckoutScreenBodyState createState() => _CheckoutScreenBodyState();
}

class _CheckoutScreenBodyState extends State<CheckoutScreenBody> {
  var selectedDeliveryMethod;

  void selectDeliveryMethod(int index) {
    setState(() {
      selectedDeliveryMethod = deliveryMethods[index];
      context.read<DeliveryCubit>().cost = selectedDeliveryMethod['cost'];
      context.read<DeliveryCubit>().getDeliveryCost();
    });
  }

  List<Map<String, dynamic>> deliveryMethods = [
    {
      'title': 'DHL',
      'image': 'assets/images/icons/dhl.svg',
      'terms': '1-2 days',
      'cost': 15
    },
    {
      'title': 'FedEx',
      'image': 'assets/images/icons/fedex.svg',
      'terms': '1-2 days',
      'cost': 18
    },
    {
      'title': 'USPS',
      'image': 'assets/images/icons/usps.svg',
      'terms': '1-2 days',
      'cost': 20
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
        ),
        padding: EdgeInsets.only(
          left: 16.0,
          top: 25.0,
          right: 16.0,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/icons/location-marker.png',
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Shipping Address',
                  style: AllStyles.fontSize19w700deepPurple,
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.only(
                left: 16.0,
                top: 14.0,
                right: 16.0,
                bottom: 16.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AllColors.deepPurple.withOpacity(0.08),
                    blurRadius: 12.0,
                    offset: Offset(0, 4.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Oleh Chabanov',
                        style: AllStyles.fontSize14w600deepPurple,
                      ),
                      Row(
                        children: [
                          GradientText(
                            text: 'Change',
                            style: AllStyles.fontSize12w700white,
                            gradient: const LinearGradient(
                              colors: AllColors.purpleGradient,
                            ),
                          ),
                          Image.asset('assets/images/icons/chevron-right.png'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '225 Highland Ave',
                          style: AllStyles.fontSize14w400lightPurpleGray,
                        ),
                        Text('Springfield, IL 62704, USA',
                            style: AllStyles.fontSize14w400lightPurpleGray)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 33.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/icons/truck.png',
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Delivery Method',
                  style: AllStyles.fontSize19w700deepPurple,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectDeliveryMethod(0);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 17.0,
                        top: 17.0,
                        right: 15.0,
                        bottom: 12.0,
                      ),
                      height: 92,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: AllColors.deepPurple.withOpacity(0.08),
                            offset: Offset(0, 4.0),
                            blurRadius: 12.0,
                          )
                        ],
                        border: Border.all(
                          color: selectedDeliveryMethod == deliveryMethods[0]
                              ? AllColors.mainYellow
                              : Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(deliveryMethods[0]['image']),
                          SizedBox(height: 12.0),
                          Text(
                            '\$${deliveryMethods[0]['cost']}',
                            style: AllStyles.fontSize14w600deepPurple,
                          ),
                          Text(
                            deliveryMethods[0]['terms'],
                            style: AllStyles.fontSize12w400lightGray,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectDeliveryMethod(1);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 21.0,
                        top: 16.0,
                        right: 21.0,
                        bottom: 12.0,
                      ),
                      height: 92,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: AllColors.deepPurple.withOpacity(0.08),
                            offset: Offset(0, 4.0),
                            blurRadius: 12.0,
                          )
                        ],
                        border: Border.all(
                          color: selectedDeliveryMethod == deliveryMethods[1]
                              ? AllColors.mainYellow
                              : Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(deliveryMethods[1]['image']),
                          SizedBox(height: 12.0),
                          Text(
                            '\$${deliveryMethods[1]['cost']}',
                            style: AllStyles.fontSize14w600deepPurple,
                          ),
                          Text(
                            deliveryMethods[1]['terms'],
                            style: AllStyles.fontSize12w400lightGray,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectDeliveryMethod(2);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        top: 19.0,
                        right: 11.0,
                        bottom: 12.0,
                      ),
                      height: 92,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: AllColors.deepPurple.withOpacity(0.08),
                            offset: Offset(0, 4.0),
                            blurRadius: 12.0,
                          )
                        ],
                        border: Border.all(
                          color: selectedDeliveryMethod == deliveryMethods[2]
                              ? AllColors.mainYellow
                              : Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(deliveryMethods[2]['image']),
                          SizedBox(height: 12.0),
                          Text(
                            '\$${deliveryMethods[2]['cost']}',
                            style: AllStyles.fontSize14w600deepPurple,
                          ),
                          Text(
                            deliveryMethods[2]['terms'],
                            style: AllStyles.fontSize12w400lightGray,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 33.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/icons/credit-card.png',
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Payment Method',
                  style: AllStyles.fontSize19w700deepPurple,
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AllColors.deepPurple.withOpacity(0.08),
                    blurRadius: 12.0,
                    offset: Offset(0, 4.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                              'assets/images/icons/mastercard.svg'),
                          SizedBox(width: 12),
                          Text(
                            '**** **** **** 5678',
                            style: AllStyles.fontSize14w600deepPurple,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GradientText(
                            text: 'Change',
                            style: AllStyles.fontSize12w700white,
                            gradient: const LinearGradient(
                              colors: AllColors.purpleGradient,
                            ),
                          ),
                          Image.asset('assets/images/icons/chevron-right.png'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
