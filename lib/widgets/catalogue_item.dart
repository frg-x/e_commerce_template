import 'package:e_commerce_template/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CatalogueItem extends StatelessWidget {
  CatalogueItem({@required this.title, @required this.image});

  final title;
  final image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 90.0,
          width: 90.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: 90.0,
          height: 90.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AllColors.deepPurple.withOpacity(1.0),
                AllColors.deepPurple.withOpacity(0.2),
              ],
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AllStyles.homeCatItemTextStyle,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
