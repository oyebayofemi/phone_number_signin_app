import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_number_signin_app/screens/login_page.dart';

class PhoneSigning extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future verifyPhoneNumber(String phoneNumber, BuildContext context,
      Function setData, String dialCodeDigits) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, 'Verification Completed');
    };

    PhoneVerificationFailed verificationFailed = (verificationFailed) async {
      showSnackBar(context, verificationFailed.toString());
    };

    PhoneCodeSent codeSent = (verficationId, resendingToken) async {
      showSnackBar(context,
          'Verification code sent to ${{dialCodeDigits + phoneNumber}}');
      setData(verficationId);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (verificationFailed) async {
      showSnackBar(context, 'Timeout');
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: '${dialCodeDigits + phoneNumber}',
      timeout: Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> signinWithPhoneNumber(
      String? verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: smsCode);

      UserCredential? userCredential =
          await _auth.signInWithCredential(credential);

      notifyListeners();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signout(BuildContext context) async {
    try {
      await _auth.signOut();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
