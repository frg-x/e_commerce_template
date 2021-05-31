import 'package:flutter/material.dart';

import 'enter_phone_screen.dart';

class GetStarted extends StatefulWidget {
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
            Image.asset(
              'assets/images/get_started_overlay.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Positioned(
              right: 0,
              bottom: 220,
              child: Image.asset(
                'assets/images/rect_35.png',
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 291,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/rect_36.png'),
                    fit: BoxFit.fill,
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
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 31.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE7B944),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Shop',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 31.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.35,
                        color: Colors.white,
                        fontFamily: 'SFProText',
                      ),
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFFE7B944),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
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
