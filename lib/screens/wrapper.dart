import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_number_signin_app/form_Widget/mobile_form_widget.dart';
import 'package:phone_number_signin_app/screens/login_page.dart';
import 'package:phone_number_signin_app/services/phone_signin_controller.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      //initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return LoginPage();
        } else {
          return GetMobileFormWidget();
        }
      },
    );
  }
}
