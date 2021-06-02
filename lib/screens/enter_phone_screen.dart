import 'package:e_commerce_template/screens/verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EnterPhoneScreen extends StatefulWidget {
  static const routeName = '/enter-phone';

  final List<Map<String, String>> countries = [
    {'country': 'UA', 'code': '+380'},
    {'country': 'RU', 'code': '+7'},
    {'country': 'US', 'code': '+1'},
    {'country': 'PL', 'code': '+48'},
  ];

  @override
  _EnterPhoneScreenState createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  bool showNextStep = false;
  bool showClearIcon = false;
  late String unformattedText;
  TextEditingController _phoneNumberController = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) ### ## ##', filter: {"#": RegExp(r'[0-9]')});

  void _validatePhoneNumber(String text) {
    unformattedText = maskFormatter.getUnmaskedText();
    setState(() {
      showNextStep = unformattedText.length == 9 ? true : false;
      showClearIcon = unformattedText.length > 0 ? true : false;
    });
  }

  void _clearText() {
    setState(() {
      _phoneNumberController.clear();
      unformattedText = '';
      showNextStep = false;
      showClearIcon = false;
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dropDownValue = 'UA';
    var selectedCountry =
        widget.countries.firstWhere((item) => item['country'] == dropDownValue);

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
                'What Is Your Phone \nNumber?',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
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
                  Text(
                    'Please enter your phone number to verify your account',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    onChanged: _validatePhoneNumber,
                    inputFormatters: [maskFormatter],
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Color(0xFF605A65),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: EdgeInsets.only(left: 18.0),
                        width: 80.0,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/countries/${selectedCountry['country']}.png',
                              width: 32.0,
                              height: 32.0,
                            ),
                            SizedBox(
                              child: Icon(Icons.keyboard_arrow_down),
                              width: 8.0,
                            ),
                          ],
                        ),
                      ),
                      prefixStyle: TextStyle(
                        color: Color(0xFF605A65),
                        fontSize: 19.0,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixText: '${selectedCountry['code']} ',
                      suffixIcon: IconButton(
                        icon: showClearIcon ? Icon(Icons.clear) : Container(),
                        color: Colors.black54,
                        onPressed: _clearText,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(8.0),
                        ),
                        borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(8.0),
                        ),
                        borderSide: BorderSide(color: Color(0xFFE1E1E1)),
                      ),
                      hintText: '(99) 999 99 99',
                      hintStyle: TextStyle(
                        color: Color(0xFFE1E1E1),
                        fontSize: 19.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  SizedBox(
                    height: 64.0,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: showNextStep
                          ? () {
                              Navigator.pushNamed(
                                  context, VerificationScreen.routeName,
                                  arguments:
                                      '${selectedCountry['code']}$unformattedText');
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
                      print('Skip');
                    },
                    child: Text(
                      'Skip',
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
