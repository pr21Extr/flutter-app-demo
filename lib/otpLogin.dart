import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
class phoneNumber extends StatefulWidget {
  const phoneNumber({super.key});

  @override
  State<phoneNumber> createState() => _phoneNumberState();
}

class _phoneNumberState extends State<phoneNumber> {
  TextEditingController phoneController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDRecieved ='';
  bool otpCodeVisibility =false;

  TextEditingController otpCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP verify'),



      ),
      body:Column(
        children: [
          Visibility(
            visible: otpCodeVisibility,
            child: TextField(
              controller: phoneController ,
            ),
          ),

        SizedBox(height: 10),
      TextField(
        controller: otpCodeController,
      ),
          ElevatedButton(onPressed: (){

            verifyNumber();
          },
              child: Text(otpCodeVisibility ? "Login ": "Verify"))
        ],
      )
    );
  }

void verifyNumber (){
auth.verifyPhoneNumber(
    phoneNumber: phoneController.text,
    verificationCompleted: (PhoneAuthCredential credential) async {
   await auth.signInWithCredential(credential).then((value) {
      print('Login success')
    });
    },
    verificationFailed: (FirebaseAuthException exception){
      print(exception.message);
    },
    codeSent: (String verificationID , int? resendToken ){
      otpCodeVisibility= true;
      verificationIDRecieved = verificationID;

    },
    codeAutoRetrievalTimeout: (String verificationID){

      setState(() {
        
      });
    }
);
}
}
