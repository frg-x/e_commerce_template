import 'dart:ui';

import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/widgets/appbar/filter_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FilterAppBar(),
      backgroundColor: AllColors.tabsScreenBgColor,
      extendBody: true,
      body: FilterBody(),
    );
  }
}

class FilterBody extends StatefulWidget {
  @override
  _FilterBodyState createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  RangeValues _values = RangeValues(470, 5000);

  List<Map<String, dynamic>> filterColors = [
    {
      'color': Color(0xFF34283E),
      'isActive': true,
    },
    {
      'color': Color(0xFFCE3E3E),
      'isActive': false,
    },
    {
      'color': Color(0xFF76B559),
      'isActive': false,
    },
    {
      'color': Color(0xFF5D72E1),
      'isActive': false,
    },
    {
      'color': Color(0xFFB768B9),
      'isActive': false,
    },
    {
      'color': Color(0xFFE5D227),
      'isActive': false,
    },
  ];

  List<Map<String, dynamic>> filterSizes = [
    {
      'size': 'XXS',
      'isActive': false,
    },
    {
      'size': 'XS',
      'isActive': true,
    },
    {
      'size': 'S',
      'isActive': false,
    },
    {
      'size': 'M',
      'isActive': true,
    },
    {
      'size': 'L',
      'isActive': false,
    },
    {
      'size': 'XL',
      'isActive': false,
    },
  ];

  void selectColor(int index) {
    setState(() {
      filterColors[index]['isActive'] = !filterColors[index]['isActive'];
    });
  }

  void selectSize(int index) {
    setState(() {
      filterSizes[index]['isActive'] = !filterSizes[index]['isActive'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 24.0,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Price',
              style:
                  AllStyles.fontSize14w600.copyWith(color: AllColors.lightGray),
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AllColors.mainYellow,
              trackHeight: 4.0,
              inactiveTickMarkColor: Colors.black,
              inactiveTrackColor: Colors.grey.shade400.withAlpha(100),
              thumbColor: Colors.white,
              overlayColor: AllColors.mainYellow.withAlpha(128),
              overlayShape: RoundSliderOverlayShape(
                overlayRadius: 22.0,
              ),
              trackShape: CustomTrackShape(),
              thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 30.0, disabledThumbRadius: 30.0),
            ),
            child: RangeSlider(
              min: 0,
              max: 8000,
              values: _values,
              onChanged: (values) {
                setState(() {
                  _values = values;
                  //print(_values);
                });
              },
            ),
          ),
          ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AllColors.phoneNumTextFieldBorder),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 48.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        '\$${_values.start.toStringAsFixed(0)}',
                        style: AllStyles.fontSize14w400lightPurpleGray,
                      ),
                    ),
                  ),
                  Divider(
                    color: AllColors.phoneNumTextFieldBorder,
                    indent: 1.0,
                  ),
                  Flexible(
                    child: Container(
                      height: 48.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        '\$${_values.end.toStringAsFixed(0)}',
                        style: AllStyles.fontSize14w400lightPurpleGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text(
              'Categories',
              style:
                  AllStyles.fontSize14w600.copyWith(color: AllColors.lightGray),
            ),
          ),
          ClipRRect(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
              height: 48.0,
              decoration: BoxDecoration(
                border: Border.all(color: AllColors.phoneNumTextFieldBorder),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Dresses',
                      style: AllStyles.fontSize14w400lightPurpleGray,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AllColors.lightGray,
                    size: 18.0,
                  ),
                ],
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text(
              'Brands',
              style:
                  AllStyles.fontSize14w600.copyWith(color: AllColors.lightGray),
            ),
          ),
          ClipRRect(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
              height: 48.0,
              decoration: BoxDecoration(
                border: Border.all(color: AllColors.phoneNumTextFieldBorder),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Lark & Ro, Astylish, ECOWISH, Angashion',
                      style: AllStyles.fontSize14w400lightPurpleGray,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AllColors.lightGray,
                    size: 18.0,
                  ),
                ],
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text(
              'Colors',
              style:
                  AllStyles.fontSize14w600.copyWith(color: AllColors.lightGray),
            ),
          ),
          Container(
            height: 46,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int index = 0; index < filterColors.length; index++)
                  GestureDetector(
                    onTap: () => selectColor(index),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        filterColors[index]['isActive']
                            ? SizedBox(
                                width: 46,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AllColors.tabsScreenBgColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(44.0)),
                                    border: Border.all(
                                      color: AllColors.mainYellow,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: 46,
                              ),
                        SizedBox(
                          width: 37,
                          height: 37,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                              color: filterColors[index]['color'],
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
              style:
                  AllStyles.fontSize14w600.copyWith(color: AllColors.lightGray),
            ),
          ),
          Container(
            height: 47,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int index = 0; index < filterSizes.length; index++)
                  GestureDetector(
                    onTap: () => selectSize(index),
                    child: SizedBox(
                      width: 47,
                      height: 47,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: filterSizes[index]['isActive']
                              ? AllColors.mainYellow
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            filterSizes[index]['size'],
                            style: filterSizes[index]['isActive']
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
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text(
              'Sort by',
              style:
                  AllStyles.fontSize14w600.copyWith(color: AllColors.lightGray),
            ),
          ),
          ClipRRect(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
              height: 48.0,
              decoration: BoxDecoration(
                border: Border.all(color: AllColors.phoneNumTextFieldBorder),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Featured',
                      style: AllStyles.fontSize14w400lightPurpleGray,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AllColors.lightGray,
                    size: 18.0,
                  ),
                ],
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          SizedBox(height: 32.0),
          SizedBox(
            height: 48.0,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {},
              style: AllStyles.getStartedMainButtonStyle,
              child: Text(
                'Results (166)',
                style: AllStyles.fontSize17w700white,
              ),
            ),
          ),
          SizedBox(height: 34.0),
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
