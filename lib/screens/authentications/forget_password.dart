import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/components/k_components.dart';
import 'package:gromify/screens/dashboard.dart';
import 'package:lottie/lottie.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: SafeArea(
          child: Column(
            children: [
              Lottie.asset('assets/login.json',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text('DeveStyle', style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),),
              const SizedBox(
                height: 30.0,
              ),
              const Text('Enter your contact number to reset password'),
              const SizedBox(
                height: 12.0,
              ),
              Container(
                height: 60,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: kTextFormFieldDecoration.copyWith(
                      labelText: 'Contact', prefixText: '+92'),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              MaterialButton(
                onPressed: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>HomePageScreen()));
                },
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: const Color(0xff8471FF),
                child: const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('Enter',style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                    color: Colors.white
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
