import 'dart:ffi';
import 'package:authentication/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../service/auth_services.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({
    Key? key,
    required this.phoneNumber,
    required this.onOtpComplete,
    required this.onTap,
  }) : super(key: key);
  final String phoneNumber;
  final Function(String) onOtpComplete;
  final VoidCallback onTap;
  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  late final TextEditingController otpController;
  String? verificationId;
  String? phoneCode;
  bool isOtpComplete = false;
  void otpListener() {
    final otp = otpController.text.trim();
    if (otp.isNotEmpty) {
      phoneCode = otp;
      widget.onOtpComplete(phoneCode!);
    }
    if (otp.isNotEmpty && otp.length == 6 ) {
      setState(() {
        isOtpComplete = true;
      });
    } else {
      setState(() {
        isOtpComplete = false;
      });
    }
  }

  void getVerificationID() async {
    verificationId = await AuthService().loginWithPhone(widget.phoneNumber);
  }

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    otpController.addListener(otpListener);
    getVerificationID();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                }, icon: const Icon(Icons.arrow_back)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter OTP',
                  style: GoogleFonts.lora(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: const Color(0xff2C3234),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    'A five digit code has been sent to ${widget.phoneNumber}'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text('Incorrect number? '),
                    Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffBFFB62),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height / 7,
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: otpController,
                  showCursor: false,
                  pinTheme: PinTheme(
                    inactiveColor: const Color(0XFF9B9B9B),
                    activeColor: const Color(0XFF9B9B9B),
                    selectedColor: const Color(0XFF9B9B9B),
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: width,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: const Color(0xffBFFB62)),
                    child: Text(
                      isOtpComplete ? 'Done' : 'Resend OTP',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Color(0xff2C3234),
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  onTap: () async {
                    if (isOtpComplete ) {
                      // await AuthService().signinWithCredential(
                      //     verificationId: verificationId!,
                      //     phoneCode: phoneCode!);

                      // ScaffoldMessenger.of(context)
                      //     .showSnackBar(const SnackBar(
                      //   content: Text('Successfully Verified'),
                      //   backgroundColor: Colors.red,
                      // ));
                      widget.onTap;

                      return;
                    }
                    getVerificationID();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
