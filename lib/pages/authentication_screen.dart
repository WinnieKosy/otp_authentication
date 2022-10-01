import 'package:authentication/pages/signin_page.dart';
import 'package:authentication/pages/signup_page.dart';
import 'package:flutter/material.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int index = 0;
  List<Widget> screen = [
    const SignUp(),
    const SignIn(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 161,
                height: 40,
                decoration: BoxDecoration(
                    border:
                    Border.all(color: const Color(0xffE2E2E2), width: 1),
                    borderRadius: BorderRadius.circular(35)),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              index = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: index == 1
                                    ? const Color(0xffBFFB62)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(35)),
                            child: const Center(
                              child: Text(
                                'Signin',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xff2C3234),
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                          ),
                        )),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              index = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: index == 0
                                    ? const Color(0xffBFFB62)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(35)),
                            child: const Center(
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xff2C3234),
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Expanded(child: screen[index])
            ],
          ),
        ),
      ),
    );
  }
}
