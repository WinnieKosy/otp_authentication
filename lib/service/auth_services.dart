import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool otpVisibility = false;

  String verificationIDRecieved = "";

  Future<String?> loginWithPhone(String number) async {
    String? verificationID;
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print('verification $verificationID');
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        print('before $verificationID');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    print('after $verificationID');
    return verificationID;
  }

  Future<void> signinWithCredential({
    required String verificationId,
    required String phoneCode,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: phoneCode);
    await firebaseAuth.signInWithCredential(credential);
  }
}
