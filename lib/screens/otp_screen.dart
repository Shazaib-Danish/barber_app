import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/firebase_authentications/firebase_authen.dart';
import 'package:gromify/model/user_model.dart';
import 'package:gromify/screens/dashboard.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.user}) : super(key: key);

  final UserInformation user;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.grey[700],
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: SafeArea(
          child: Column(
            children: [
              Lottie.asset(
                'assets/login.json',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Phone Verification',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Enter 6 digit code send to your number ${widget.user.userContact}',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Pinput(
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (s) {},
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) async {
                  setState(() {
                    isLoading = true;
                  });
                  verify(pin, context, widget.user)
                      .whenComplete(() => setState(() {
                            isLoading = false;
                          }));
                },
              ),
              const SizedBox(
                height: 40.0,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => HomePageScreen()));
                },
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: const Color(0xff8471FF),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Verify',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
