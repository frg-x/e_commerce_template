import 'package:e_commerce_template/countries_code.dart';
import 'package:e_commerce_template/screens/tabs_screen.dart';
import 'package:e_commerce_template/screens/sign_and_verify_screens/verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:e_commerce_template/constants.dart';

class EnterPhoneScreen extends StatefulWidget {
  static const routeName = '/enter-phone';

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
      showNextStep
          ? FocusScope.of(context).requestFocus(new FocusNode())
          // ignore: unnecessary_statements
          : null;
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
        countries.firstWhere((item) => item['isoCode'] == dropDownValue);

    //print(selectedCountry);

    //var _currentSelectedItem = selectedCountry['isoCode'];

    InputDecoration phoneNumInputDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 0,
      ),
      prefixIcon: Container(
        padding: EdgeInsets.only(left: 18.0),
        width: 90.0,
        child: Row(
          children: [
            SizedBox(
              child: Image.network(
                selectedCountry['flag']!,
                fit: BoxFit.cover,
              ),
              width: 36.0,
              height: 36.0,
            ),
            SizedBox(
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AllColors.lightPurpleGray,
                  size: 20,
                ),
                onPressed: () {},
              ),
              width: 6.0,
            ),
          ],
        ),
      ),
      prefixStyle: TextStyle(
        color: AllColors.lightPurpleGray,
        fontSize: 19.0,
        fontWeight: FontWeight.w400,
      ),
      prefixText: '${selectedCountry['dialCode']} ',
      suffixIcon: IconButton(
        icon: showClearIcon ? Icon(Icons.clear) : Container(),
        color: Colors.black54,
        onPressed: _clearText,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(8.0),
        ),
        borderSide: BorderSide(color: AllColors.phoneNumTextFieldBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(8.0),
        ),
        borderSide: BorderSide(color: AllColors.phoneNumTextFieldBorder),
      ),
      hintText: '(99) 999 99 99',
      hintStyle: TextStyle(
        color: AllColors.phoneNumTextFieldBorder,
        fontSize: 19.0,
        fontWeight: FontWeight.w400,
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'corner',
              child: Container(
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
                  'What Is Your Phone \nNumber?',
                  style:
                      AllStyles.SFProDisplay25w700white.copyWith(height: 1.24),
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
                    style: AllStyles.fontSize17w400,
                  ),
                  SizedBox(height: 24.0),
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    onChanged: _validatePhoneNumber,
                    autofocus: true,
                    inputFormatters: [maskFormatter],
                    style: TextStyle(
                      fontSize: 19.0,
                      color: AllColors.lightPurpleGray,
                    ),
                    decoration: phoneNumInputDecoration,
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
                                      '${selectedCountry['dialCode']}$unformattedText');
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
                  SizedBox(height: 12.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, TabsScreen.routeName);
                    },
                    child: Text(
                      'Skip',
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

class DropDownMenu extends StatefulWidget {
  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  late String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DropDown'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(0.0),
          child: DropdownButton<String>(
            value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),
            items: [
              DropdownMenuItem(
                child: Text('AZ'),
              ),
            ],
            hint: Text(
              "Please choose a language",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: (value) {
              setState(() {
                _chosenValue = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
