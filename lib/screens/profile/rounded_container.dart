import 'package:e_commerce_template/constants.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  RoundedContainer({
    required this.image,
    required this.title,
    required this.onPress,
  });

  final String image;
  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 12.0,
              color: AllColors.deepPurple.withOpacity(0.08),
              offset: Offset(0, 4.0),
            )
          ],
        ),
        child: Center(
          child: Row(
            children: [
              Image.asset(image),
              const SizedBox(width: 12.0),
              Text(
                title,
                style: AllStyles.fontSize17w600deepPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
