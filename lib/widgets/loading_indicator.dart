import 'package:e_commerce_template/constants.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Center(
        child: CircularProgressIndicator(
          color: AllColors.circularProgressIndicatorColor,
          strokeWidth: 5,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
