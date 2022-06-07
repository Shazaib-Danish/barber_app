import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/firebase_data/firebase_data.dart';
import 'package:gromify/model/user_model.dart';
import 'package:gromify/screens/dashboard.dart';
import 'package:provider/provider.dart';

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

Future<void> verify(smsCode, BuildContext context, UserInformation user) async {
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID, smsCode: smsCode);
  late String code;
  try {
    await FirebaseAuth.instance.signInWithCredential(credential);
    try {
      final userResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.userEmail, password: user.userPassword);
      if (userResult != null) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: user.userEmail, password: user.userPassword).whenComplete(() {
          addProfileData(user);
          Provider.of<DataManagerProvider>(context, listen: false).setUserProfile(user);
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePageScreen()),
            (Route<dynamic> route) => false);
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

Future<void> signIn(String email, String password, BuildContext context) async {
  try {
    final userResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (userResult != null) {
      await getUserProfile(email, context).whenComplete(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePageScreen()),
                (Route<dynamic> route) => false);
      });
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${e.message}')));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}
