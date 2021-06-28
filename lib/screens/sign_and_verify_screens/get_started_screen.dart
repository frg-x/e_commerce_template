import 'package:e_commerce_template/constants.dart';
import 'package:flutter/material.dart';
import 'enter_phone_screen.dart';

class GetStarted extends StatefulWidget {
  static const routeName = '/get-started';

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/main_gif.gif',
              fit: BoxFit.cover,
              scale: 0.5,
              height: 600,
            ),
            Container(
              height: 560,
              width: MediaQuery.of(context).size.width,
              color: AllColors.getStartedContainerOverlay.withAlpha(77),
            ),
            Positioned(
              right: 0,
              bottom: 220,
              child: Hero(
                  tag: 'corner',
                  child: Container(
                    height: 146.0,
                    width: 269.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(300.0),
                      ),
                      color: AllColors.mainYellow.withAlpha(179),
                    ),
                  ),
                  // createRectTween: (begin, end) {
                  //   return CustomRectTween(begin!, end!);
                  // },
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    Animation<double> newAnimation =
                        Tween<double>(begin: 0, end: 0.5).animate(animation);

                    if (flightDirection == HeroFlightDirection.pop) {
                      newAnimation = ProxyAnimation(newAnimation);
                    }

                    return RotationTransition(
                      turns: newAnimation,
                      child: Container(
                        height: 146.0,
                        width: 269.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(300.0),
                          ),
                          color: AllColors.mainYellow.withAlpha(179),
                        ),
                      ),
                    );
                  }),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 291,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: AllColors.purpleGradient,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'My',
                          style: AllStyles.getStartedTitle31_My,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Shop',
                          style: AllStyles.getStartedTitle31_Shop,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                      style: AllStyles.getStartedSubText,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                    const SizedBox(height: 32.0),
                    SizedBox(
                      height: 48.0,
                      width: 239.0,
                      child: TextButton(
                        onPressed: () {
                          // Navigator.pushReplacementNamed(
                          //     context, EnterPhoneScreen.routeName);
                          Navigator.pushNamed(
                              context, EnterPhoneScreen.routeName);
                        },
                        style: AllStyles.getStartedMainButtonStyle,
                        child: Text(
                          'Get Started',
                          style: AllStyles.fontSize17w700white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomRectTween extends RectTween {
//   final Rect begin;
//   final Rect end;
//
//   CustomRectTween(this.begin, this.end) : super(begin: begin, end: end);
//
//   @override
//   Rect lerp(double t) {
//     double x = Curves.easeOut.transform(t);
//
//     return Rect.fromLTRB(
//       lerpDouble(begin.left, end.left, t),
//       lerpDouble(begin.top, end.top, t),
//       lerpDouble(begin.right, end.right, t) * (1 + x),
//       lerpDouble(begin.bottom, end.bottom, t) * (1 + x),
//     );
//   }
//
//   double lerpDouble(num begin, num end, double t) {
//     return begin + (end - begin) * t;
//   }
// }
