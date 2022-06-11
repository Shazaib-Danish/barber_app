import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/components/k_components.dart';
import 'package:gromify/firebase_authentications/firebase_authen.dart';
import 'package:gromify/screens/otp_screen.dart';
import 'package:gromify/widgets/cust_barber_dropdown.dart';
import 'package:lottie/lottie.dart';

import '../model/user_model.dart';
import 'login _screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController contactController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  late String roll;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 1.0,
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/signup.json',
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    controller: fullNameController,
                    cursorColor: const Color(0xff8471FF),
                    style: const TextStyle(fontSize: 18.0),
                    decoration: kTextFormFieldDecoration.copyWith(
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: const Color(0xff8471FF),
                    style: const TextStyle(fontSize: 18.0),
                    decoration: kTextFormFieldDecoration.copyWith(
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    controller: contactController,
                    keyboardType: TextInputType.number,
                    cursorColor: const Color(0xff8471FF),
                    style: const TextStyle(fontSize: 18.0),
                    decoration: kTextFormFieldDecoration.copyWith(
                        labelText: 'Contact', prefixText: '+92'),
                  ),
                ),
                ReusableDropDown(onChanged: (value) {
                  setState(() {
                    roll = value!;
                  });
                }),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    controller: passwordController,
                    cursorColor: const Color(0xff8471FF),
                    style: const TextStyle(fontSize: 18.0),
                    obscureText: true,
                    decoration: kTextFormFieldDecoration.copyWith(
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    controller: rePasswordController,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 18.0),
                    obscureText: true,
                    decoration: kTextFormFieldDecoration.copyWith(
                      labelText: 'Re-Enter Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (fullNameController.text.isEmpty &&
                        emailController.text.isEmpty &&
                        contactController.text.isEmpty &&
                        roll == 'Select' &&
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all the fields')));
                    } else {
                      if (passwordController.text !=
                          rePasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Password Not match')));
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        final userModel = CustomerInfo(
                            customerFullName: fullNameController.text,
                            customerEmail: emailController.text,
                            customerContact: '+92${contactController.text}',
                            roll: roll,
                            customerPassword: rePasswordController.text);
                        sendSms(userModel.customerContact).whenComplete(() {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      OtpScreen(user: userModel)));
                        });
                      }
                    }
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
                            'Signup',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have account? '),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF8499F0)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
