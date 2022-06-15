import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/firebase_data/firebase_data.dart';
import 'package:gromify/model/user_model.dart';
import 'package:gromify/screens/barber/barber_dashboard.dart';
import 'package:gromify/screens/dashboard.dart';
import 'package:gromify/screens/authentications/login%20_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/barber/shop_details_screen.dart';

String verificationID = '';

Future<void> sendSms(String phoneNumber) async {
  String id = '';
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {
      verificationID = verificationId;
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}

Future<void> verify(
    smsCode, BuildContext context, CustomerInfo customer) async {
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID, smsCode: smsCode);
  late String code;
  late SharedPreferences login;
  try {
    login = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signInWithCredential(credential);
    try {
      final userResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: customer.customerEmail,
              password: customer.customerPassword);
      if (userResult != null) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: customer.customerEmail,
                password: customer.customerPassword)
            .whenComplete(() {
          if (customer.roll == 'Customer') {
            Provider.of<DataManagerProvider>(context, listen: false)
                .setCustomerProfile(customer);
            addCustomerProfileData(customer, context);
            login.setString('email', customer.customerEmail);
            login.setString('password', customer.customerPassword);
            login.setString('roll', customer.roll);
            login.setBool('login', false);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePageScreen()),
                (Route<dynamic> route) => false);
          } else {
            Provider.of<DataManagerProvider>(context, listen: false)
                .setBarberBasicInformation(
                    userResult.user!.uid,
                    customer.customerFullName,
                    customer.customerEmail,
                    customer.customerContact);
            login.setString('email', customer.customerEmail);
            login.setString('password', customer.customerPassword);
            login.setString('roll', customer.roll);
            login.setBool('login', false);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ShopDetailsScreen()),
                (Route<dynamic> route) => false);
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.message}')));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-verification-code') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid code')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}

Future<void> signIn(
    String email, String password, String roll, BuildContext context) async {
  try {
    final userResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (userResult != null) {
      if (roll == 'Customer') {
        await getCustomerProfile(email, context).whenComplete(() {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePageScreen()),
              (Route<dynamic> route) => false);
        });
      } else {
        await getBarberProfile(email, context).whenComplete(() {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BarberDashboard()),
              (Route<dynamic> route) => false);
        });
      }
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${e.message}')));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}
