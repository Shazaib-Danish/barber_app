import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/components/k_components.dart';
import 'package:gromify/firebase_authentications/firebase_authen.dart';
import 'package:gromify/screens/forget_password.dart';
import 'package:gromify/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  late SharedPreferences login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/logo.png'),
                // Lottie.asset(
                //   'assets/login.json',
                //   height: MediaQuery.of(context).size.height * 0.3,
                //   width: MediaQuery.of(context).size.width * 0.7,
                // ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'DeveStyle',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20.0,
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
                const SizedBox(
                  height: 5.0,
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const ForgetPasswordScreen()));
                  },
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forget Password?',style: TextStyle(
                      color: Colors.black
                    ),),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                MaterialButton(
                  elevation: 10.0,
                  onPressed: ()async {
                    login = await SharedPreferences.getInstance();
                    setState(() {
                      isLoading = true;
                    });
                    signIn(
                        emailController.text, passwordController.text, context).whenComplete(() => setState((){
                      login.setString('email', emailController.text);
                      login.setString('password', passwordController.text);
                      login.setBool('login', false);
                      isLoading = false;
                    }));

                  },
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: const Color(0xff8471FF),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0,
                              color: Colors.white
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have account? ',style: TextStyle(
                        color: Colors.black
                    ),),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF8499F0)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
