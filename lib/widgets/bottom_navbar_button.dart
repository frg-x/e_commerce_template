import 'package:e_commerce_template/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class BottomNavBarButton extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final Function()? onPress;

  BottomNavBarButton({
    required this.title,
    required this.image,
    required this.onPress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Ink.image(
              image: Svg(image),
              width: 24.0,
              height: 24.0,
              //fit: BoxFit.scaleDown,
            ),
            SizedBox(height: 7.0),
            Text(
              title,
              style: AllStyles.bottomNavBarItemTextStyle.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
