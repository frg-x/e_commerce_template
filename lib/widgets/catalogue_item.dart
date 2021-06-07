import 'package:flutter/material.dart';

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
          height: 88.0,
          width: 88.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: 88.0,
          height: 88.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF34283E).withOpacity(1.0),
                Color(0xFF34283E).withOpacity(0.2),
              ],
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SF-Pro-Text',
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: Colors.white,
              letterSpacing: -0.15,
            ),
          ),
        ),
      ],
    );
  }
}
