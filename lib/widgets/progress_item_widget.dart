import 'package:e_commerce_template/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressItemWidget extends StatelessWidget {
  final animationStatus;

  ProgressItemWidget({required this.animationStatus});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: LinearPercentIndicator(
        lineHeight: 2.0,
        percent: animationStatus ? 1 : 0,
        animation: true,
        animationDuration: autoScrollDuration * 1000,
        curve: Curves.linear,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        progressColor: Colors.white,
      ),
    );
  }
}
