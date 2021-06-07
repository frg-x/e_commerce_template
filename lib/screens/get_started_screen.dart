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
            Container(
              height: 560,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF2A034B).withAlpha(77),
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
                  color: Color(0xFFE7B944).withAlpha(179),
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
                    colors: [
                      Color(0xFF34283E),
                      Color(0xFF845FA1),
                    ],
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
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 31.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFE7B944),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Shop',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 31.0,
                            fontWeight: FontWeight.w800,
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
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
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
                            fontWeight: FontWeight.w700,
                          ),
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
