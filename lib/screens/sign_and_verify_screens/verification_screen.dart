import 'package:e_commerce_template/constants.dart';
import 'package:e_commerce_template/screens/tabs_screen.dart';
import 'package:e_commerce_template/screens/verify_user_status_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verification';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool showNextStep = false;
  String otp = '';
  String verificationId = '';
  String phoneNumber = '';
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController pinCodeController = TextEditingController();

  void _validatePin(String pin) {
    setState(() {
      otp = pin;
      showNextStep = pin.length == 6 ? true : false;
    });
  }

  void _resendCode() {
    setState(() {
      showNextStep = false;
      pinCodeController.clear();
    });
    _verifyPinCode();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future _verifyPinCode() async {
    //print(otp);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            //print('Logged!');
            Navigator.pushNamed(context, TabsScreen.routeName);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        // if (e.code == 'invalid-phone-number') {
        //   print('The provided phone number is not valid.');
        // }
        print(e.message);
        showSnackBar(e.message.toString());
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        setState(() {
          this.verificationId = verificationId;
        });
      },
    );
  }

  @override
  void didChangeDependencies() {
    phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    _verifyPinCode();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 24.0, top: 91.0),
              width: MediaQuery.of(context).size.width,
              height: 197.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(300.0),
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: AllColors.purpleGradient,
                ),
              ),
              child: Text(
                'Verification\nCode',
                style: AllStyles.SFProDisplay25w700.copyWith(
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
                      style: AllStyles.fontSize17w400
                          .copyWith(color: AllColors.lightPurpleGray),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        phoneNumber,
                        style: AllStyles.SFProDisplay17w700deepPurple,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Change Phone Number',
                          softWrap: true,
                          style:
                              AllStyles.SFProDisplay12w400deepPurpleUnderline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  PinCodeTextField(
                    appContext: context,
                    keyboardType: TextInputType.number,
                    controller: pinCodeController,
                    length: 6,
                    autoFocus: true,
                    showCursor: false,
                    pinTheme: PinTheme(
                      disabledColor: Colors.black,
                      inactiveColor: AllColors.lightGray,
                      activeColor: Colors.green,
                      selectedColor: AllColors.lightGray,
                    ),
                    textStyle: AllStyles.SFProDisplay25w700.copyWith(
                        color: AllColors.lightPurpleGray),
                    animationType: AnimationType.none,
                    onChanged: (text) => _validatePin(text),
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    height: 64.0,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: showNextStep
                          ? () async {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithCredential(
                                        PhoneAuthProvider.credential(
                                            verificationId: verificationId,
                                            smsCode: otp))
                                    .then((value) {
                                  if (value.user != null) {
                                    Navigator.pushNamed(context,
                                        VerifyUserStatusScreen.routeName);
                                  }
                                });
                              } catch (e) {
                                FocusScope.of(context).unfocus();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Invalid OTP'),
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor: showNextStep
                            ? MaterialStateProperty.all<Color>(
                                AllColors.mainYellow,
                              )
                            : MaterialStateProperty.all<Color>(
                                AllColors.lightGray),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Send Verification Code',
                        style: AllStyles.fontSize17w700white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextButton(
                    onPressed: () {
                      _resendCode();
                    },
                    child: Text(
                      'Resend Code',
                      style: AllStyles.fontSize17w700lightGray,
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
