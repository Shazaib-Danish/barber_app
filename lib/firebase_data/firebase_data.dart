import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/model/user_model.dart';
import 'package:provider/provider.dart';

Future<void> addProfileData(UserInformation user) async {
  await FirebaseFirestore.instance.collection('Users').add({
    'fullName': user.usrFullName,
    'email': user.userEmail,
    'contact': user.userContact,
  });
}

Future<void> getUserProfile(email, BuildContext context) async {
  final userProfile = await FirebaseFirestore.instance
      .collection('Users')
      .where('email', isEqualTo: email)
      .get();
  for (var user in userProfile.docs) {
    final userData = UserInformation(
        usrFullName: user['fullName'],
        userEmail: user['email'],
        userContact: user['contact'],
        userPassword: '');
    Provider.of<DataManagerProvider>(context, listen: false)
        .setUserProfile(userData);
  }
}
