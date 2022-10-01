import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../service/auth_services.dart';
import 'otp_verification.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int index = 0;
  late final TextEditingController _phoneController;
  String? _userPhoneNumber;
  String? _countryCode;
  String? _otpCode;
  String initialCountry = 'IN';
  int? _resendToken;
  String? verificationID;

  void formatNumber() async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(_userPhoneNumber!);
    String parsableNumber = number.parseNumber();
    _userPhoneNumber = parsableNumber;
  }

  void _phoneNumberListener() {
    final value = _phoneController.text.trim();

    if (value.isNotEmpty) {
      setState(() {
        _userPhoneNumber = '$_countryCode $value';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneController.addListener(_phoneNumberListener);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 7,
              ),
              Text(
                'Welcome to App',
                style: GoogleFonts.lora(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: const Color(0xff2C3234),
                ),
              ),
              SizedBox(
                height: height / 10,
              ),
              const Text(
                'Please signup with your phone number to get registered',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Color(0xff2C3234)),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffE2E2E2))),
                height: 55,
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber value) {
                    _countryCode = value.dialCode;
                  },
                  inputBorder: InputBorder.none,
                  initialValue: PhoneNumber(isoCode: 'IN'),
                  errorMessage: 'Invalid Number',
                  textFieldController: _phoneController,
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: width,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: const Color(0xffBFFB62)),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Color(0xff2C3234),
                        fontStyle: FontStyle.normal),
                  ),
                ),
                onTap: () {
                  formatNumber();
                  if (_userPhoneNumber != null) {
                    FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: _userPhoneNumber,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          print('verification failed ${e.message}');
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          verificationID = verificationId;
                          _resendToken = resendToken;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpVerification(
                                phoneNumber: _userPhoneNumber!,
                                onOtpComplete: (String value) {
                                  _otpCode = value;
                                },
                                onTap: () async {
                                  await AuthService().signinWithCredential(
                                    verificationId: verificationId,
                                    phoneCode: _otpCode!,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Successfully Verified'),
                                    backgroundColor: Colors.red,
                                  ));
                                },
                              ),
                            ),
                          );
                        },
                        timeout: const Duration(seconds: 25),
                        forceResendingToken: _resendToken,
                        codeAutoRetrievalTimeout: (String verificationId) {
                          verificationID = verificationId;
                        });
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  Expanded(
                      child: Divider(
                        thickness: 1,
                        height: 1,
                        color: Color(0xffE2E2E2),
                      )),
                  Text(
                    '   OR   ',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xff2C3234),
                        fontStyle: FontStyle.normal),
                  ),
                  Expanded(
                      child: Divider(
                        thickness: 1,
                        height: 1,
                        color: Color(0xffE2E2E2),
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                width: width,
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: const Color(0xffF5FFF3),
                    border: Border.all(color: const Color(0xffE2E2E2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/metamask 1.png',
                    ),
                    const Text(
                      '  Connect to ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff2C3234),
                          fontStyle: FontStyle.normal),
                    ),
                    const Text(
                      'Metamask',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xff2C3234),
                          fontStyle: FontStyle.normal),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                width: width,
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: const Color(0xffF5FFF3),
                    border: Border.all(color: const Color(0xffE2E2E2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google 1.png',
                    ),
                    const Text(
                      '  Connect to ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff2C3234),
                          fontStyle: FontStyle.normal),
                    ),
                    const Text(
                      'Google',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xff2C3234),
                          fontStyle: FontStyle.normal),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                width: width,
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: const Color(0xff100F0F),
                    border: Border.all(color: const Color(0xffE2E2E2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Vector.png',
                    ),
                    const Text(
                      '  Connect to ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xffFFFFFF),
                          fontStyle: FontStyle.normal),
                    ),
                    const Text(
                      'Apple',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xffFFFFFF),
                          fontStyle: FontStyle.normal),
                    )
                  ],
                ),
              ),
              //const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xff2C3234),
                        fontStyle: FontStyle.normal),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xffBFFB62),
                          fontStyle: FontStyle.normal),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
