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
              //width: double.infinity,
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
                    SizedBox(height: 32.0),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                      style: AllStyles.getStartedSubText,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                    SizedBox(height: 32.0),
                    SizedBox(
                      height: 48.0,
                      width: 239.0,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
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
