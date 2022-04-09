import 'package:flutter/material.dart';
import 'package:phone_number_signin_app/form_Widget/mobile_form_widget.dart';
import 'package:phone_number_signin_app/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phone_number_signin_app/screens/wrapper.dart';
import 'package:phone_number_signin_app/services/phone_signin_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Wrapper(),
      routes: {
        'getFormWidget': (context) => GetMobileFormWidget(),
      },
    );
  }
}
