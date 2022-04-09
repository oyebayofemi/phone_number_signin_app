import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:phone_number_signin_app/form_Widget/otp_from_widget.dart';
import 'package:phone_number_signin_app/services/phone_signin_controller.dart';

class GetMobileFormWidget extends StatefulWidget {
  @override
  State<GetMobileFormWidget> createState() => _GetMobileFormWidgetState();
}

class _GetMobileFormWidgetState extends State<GetMobileFormWidget> {
  //late String phoneNumber;
  TextEditingController phoneController = TextEditingController();
  String? dialCodeDigits = '+234';
  PhoneSigning auth = PhoneSigning();
  String verficationIDfinal = '';
  String codeSent = '';
  late String verification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Spacer(),
            SizedBox(
              width: 400,
              height: 60,
              child: CountryCodePicker(
                onChanged: (value) {
                  setState(() {
                    dialCodeDigits = value.dialCode;
                  });
                },
                initialSelection: 'NG',
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                showFlag: true,
                favorite: ['+234', 'NG'],
              ),
            ),
            TextField(
              maxLength: 10,
              //onChanged: (value) => phoneNumber = value,
              keyboardType: TextInputType.number,
              controller: phoneController,
              decoration: InputDecoration(
                  hintText: 'Phone Number',
                  prefix: Padding(
                      padding: EdgeInsets.all(2),
                      child: Text(dialCodeDigits!))),
            ),
            SizedBox(
              height: 30,
            ),
            ButtonTheme(
              minWidth: double.infinity,
              buttonColor: Colors.green,
              child: RaisedButton.icon(
                  onPressed: () async {
                    print('Verification code1:$verficationIDfinal');
                    this.verification = verficationIDfinal;
                    await auth
                        .verifyPhoneNumber('${phoneController.text}', context,
                            setData, '${dialCodeDigits}')
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => getOTPFormWidget(
                                  phoneController.text,
                                  verficationIDfinal,
                                  dialCodeDigits,
                                  setData),
                            )));
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  label: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void setData(verficationId) {
    setState(() {
      verficationIDfinal = verficationId;
    });
  }
}
