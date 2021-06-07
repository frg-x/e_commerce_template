import 'package:flutter/material.dart';

class AdvertisementCard extends StatelessWidget {
  AdvertisementCard({@required this.title, @required this.image});
  final title;
  final image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(image),
            ),
          ),
          //child: Text(''),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF34283E).withOpacity(1.0),
                Color(0xFF1D2332).withOpacity(0.2),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'SF-Pro-Display',
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'See more',
                    style: TextStyle(
                      fontFamily: 'SF-Pro-Text',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE7B944),
                    ),
                  ),
                  SizedBox(width: 2.0),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 14.0,
                    color: Color(0xFFE7B944),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
