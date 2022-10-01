import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late PageController pageController;
  String initialCountry = 'IN';
  int index = 0;

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
                'Welcome Back!!',
                style: GoogleFonts.lora(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: const Color(0xff2C3234),
                ),
              ),
              SizedBox(
                height: height / 8,
              ),
              const Text(
                'Please login with your phone number.',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Color(0xff2C3234)),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffE2E2E2))),
                height: 55,
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber value) {},
                  initialValue: PhoneNumber(isoCode: 'IN'),
                  errorMessage: 'Invalid Number',
                  inputBorder: InputBorder.none,
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                ),
              ),
              const SizedBox(
                height: 35,
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
                onTap: () {},
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
                    onPressed: () {},
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
