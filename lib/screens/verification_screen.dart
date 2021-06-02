import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verification';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool showNextStep = false;

  void _validatePin(String pin) {
    setState(() {
      showNextStep = pin.length == 6 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 24.0, top: 91.0),
              width: MediaQuery.of(context).size.width,
              height: 197.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/rect_35_phone.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Text(
                'Verification\nCode',
                style: TextStyle(
                  fontFamily: 'SF-Pro-Display',
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.24,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'Please enter Code sent to',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        phoneNumber,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF34283E),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Change Phone Number',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF34283E),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  OTPTextField(
                    onCompleted: (pin) => _validatePin(pin),
                    onChanged: (pin) => _validatePin(pin),
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceEvenly,
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: Colors.green,
                      disabledBorderColor: Colors.green,
                      focusBorderColor: Colors.green,
                      enabledBorderColor: Colors.green,
                    ),
                    fieldWidth: 50,
                    fieldStyle: FieldStyle.underline,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: 'SF-Pro-Display',
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF605A65),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  SizedBox(
                    height: 64.0,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: showNextStep
                          ? () {
                              print('Next Step');
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor: showNextStep
                            ? MaterialStateProperty.all<Color>(
                                Color(0xFFE7B944),
                              )
                            : MaterialStateProperty.all<Color>(
                                Colors.grey.shade400),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Send Verification Code',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  TextButton(
                    onPressed: () {
                      print('Resend Code');
                    },
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFF9B9B9B),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
