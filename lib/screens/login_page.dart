import 'package:flutter/material.dart';
import 'package:phone_number_signin_app/form_Widget/mobile_form_widget.dart';
import 'package:phone_number_signin_app/form_Widget/otp_from_widget.dart';
import 'package:phone_number_signin_app/services/phone_signin_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PhoneSigning auth = PhoneSigning();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              child: Column(
        children: [
          Text('Logged in'),
          RaisedButton(
            onPressed: () async {
              await auth.signout(context);
              Navigator.pushNamed(context, 'getFormWidget');
            },
            child: Text('Signout'),
          )
        ],
      ))),
    );
  }
}
