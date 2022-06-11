import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/model/barber_model.dart';
import 'package:gromify/model/user_model.dart';
import 'package:provider/provider.dart';

Future<void> addCustomerProfileData(CustomerInfo user) async {
  await FirebaseFirestore.instance.collection('Customer').add({
    'fullName': user.customerFullName,
    'email': user.customerEmail,
    'contact': user.customerContact,
  });
}

Future<void> getUserProfile(email, BuildContext context) async {
  final userProfile = await FirebaseFirestore.instance
      .collection('Customer')
      .where('email', isEqualTo: email)
      .get();
  for (var user in userProfile.docs) {
    final userData = CustomerInfo(
      customerFullName: user['fullName'],
      customerEmail: user['email'],
      customerContact: user['contact'],
      roll: 'Customer',
      customerPassword: '',
    );
    Provider.of<DataManagerProvider>(context, listen: false)
        .setCustomerProfile(userData);
  }
}

Future<void> addBarberProfileData(BuildContext context) async {
  final barber = Provider.of<DataManagerProvider>(context, listen: false).getBarberDetails;
  try{
    await FirebaseFirestore.instance.collection('Barbers').add({
      'fullName': barber.barber.barberFullName,
      'email': barber.barber.barberEmail,
      'contact': barber.barber.barberContact,
      'seats': barber.seats,
      'description': barber.description,
      'rating': 0.0,
      'goodReviews': 0,
      'totalScore': 0,
      'satisfaction': 0,
      'image': barber.image,
      'address': barber.location.address,
      'latitude': barber.location.latitude,
      'longitude': barber.location.longitude,
      'startTime' : barber.shopStatus.startTime,
      'endTIme' : barber.shopStatus.endTime,
      'shopStatus' : barber.shopStatus.status,
    });
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}
