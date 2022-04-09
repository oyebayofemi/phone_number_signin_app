import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phone_number_signin_app/services/phone_signin_controller.dart';
import 'package:pinput/pin_put/pin_put.dart';

class getOTPFormWidget extends StatefulWidget {
  final String phone;
  final String verficationIDfinal;
  String? dialCodeDigits;
  Function setData;
  getOTPFormWidget(
      this.phone, this.verficationIDfinal, this.dialCodeDigits, this.setData);

  @override
  State<getOTPFormWidget> createState() => _getOTPFormWidgetState();
}

class _getOTPFormWidgetState extends State<getOTPFormWidget> {
  int start = 30;
  bool wait = false;
  TextEditingController otpController = TextEditingController();
  String smsCode = '';
  PhoneSigning _auth = PhoneSigning();

  @override
  Widget build(BuildContext context) {
    final _pinPutFocusNode = FocusNode();
    final _pinPutController = TextEditingController();
    final verficationID = widget.verficationIDfinal;
    print('Verification Code 2: $verficationID');
    PhoneSigning auth = PhoneSigning();

    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(43, 46, 66, 1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: const Color.fromRGBO(126, 203, 224, 1),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Spacer(),
            Text('Verify ${widget.dialCodeDigits}-${widget.phone}'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                withCursor: true,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
                eachFieldWidth: 40.0,
                eachFieldHeight: 55.0,
                //onSubmit: (String pin) => _showSnackBar(pin),
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                pinAnimationType: PinAnimationType.fade,
                onSubmit: (pin) async {
                  try {
                    await _auth.signinWithPhoneNumber(
                        verficationID, pin, context);
                  } catch (e) {
                    print(e);
                    showSnackBar(context, e.toString());
                  }
                },
              ),
            ),
            InkWell(
                child: Text('Resend Code'),
                onTap: () async {
                  await auth.verifyPhoneNumber('${widget.phone}', context,
                      widget.setData, '${widget.dialCodeDigits}');
                }),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}
