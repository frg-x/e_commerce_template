import 'package:e_commerce_template/constants.dart';
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
              colors: AllColors.advCardOverlayGradient,
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
                style: AllStyles.SFProDisplay25w700white,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'See more',
                    style: AllStyles.SFProText12w700mainYellow,
                  ),
                  const SizedBox(width: 2.0),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 14.0,
                    color: AllColors.mainYellow,
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
