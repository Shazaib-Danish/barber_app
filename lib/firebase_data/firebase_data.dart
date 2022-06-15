import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/model/appointment_model.dart';
import 'package:gromify/model/barber_model.dart';
import 'package:gromify/model/user_model.dart';
import 'package:provider/provider.dart';

Future<void> addCustomerProfileData(
    CustomerInfo user, BuildContext context) async {
  try {
    await FirebaseFirestore.instance.collection('Customer').add({
      'customerId': user.customerId,
      'fullName': user.customerFullName,
      'email': user.customerEmail,
      'contact': user.customerContact,
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}

Future<void> getCustomerProfile(email, BuildContext context) async {
  try {
    final userProfile = await FirebaseFirestore.instance
        .collection('Customer')
        .where('email', isEqualTo: email)
        .get();
    for (var user in userProfile.docs) {
      final userData = CustomerInfo(
        customerId: user['customerId'],
        customerFullName: user['fullName'],
        customerEmail: user['email'],
        customerContact: user['contact'],
        roll: 'Customer',
        customerPassword: '',
      );
      Provider.of<DataManagerProvider>(context, listen: false)
          .setCustomerProfile(userData);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}

Future<void> getBarberProfile(email, BuildContext context) async {
  try {
    final userProfile = await FirebaseFirestore.instance
        .collection('Barbers')
        .where('email', isEqualTo: email)
        .get();
    late BarberModel barbP;

    for (var data in userProfile.docs) {
      BarberInfo barber = BarberInfo(
          barberId: data['barberId'],
          barberFullName: data['fullName'],
          barberEmail: data['email'],
          barberContact: data['contact'],
          roll: 'Barbers',
          barberPassword: '');

      Location location = Location(
          address: data['address'],
          latitude: data['latitude'],
          longitude: data['longitude']);

      ShopStatus status = ShopStatus(
          status: data['shopStatus'],
          startTime: data['startTime'],
          endTime: data['endTime']);

      barbP = BarberModel(
          shopName: data['shopName'],
          barber: barber,
          seats: data['seats'],
          description: data['description'],
          rating: double.parse("${data['rating']}"),
          goodReviews: data['goodReviews'],
          totalScore: data['totalScore'],
          satisfaction: data['satisfaction'],
          image: data['image'],
          location: location,
          shopStatus: status);
    }
    Provider.of<DataManagerProvider>(context, listen: false)
        .setBarberProfile(barbP);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}

Future<void> addBarberProfileData(BuildContext context) async {
  final barber =
      Provider.of<DataManagerProvider>(context, listen: false).getBarberDetails;
  try {
    await FirebaseFirestore.instance.collection('Barbers').add({
      'barberId': barber.barber.barberId,
      'fullName': barber.barber.barberFullName,
      'shopName': barber.shopName,
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
      'startTime': barber.shopStatus.startTime,
      'endTime': barber.shopStatus.endTime,
      'shopStatus': barber.shopStatus.status,
    });

    await FirebaseFirestore.instance.collection('Top Barbers').add({
      'barberId': barber.barber.barberId,
      'fullName': barber.barber.barberFullName,
      'shopName': barber.shopName,
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
      'startTime': barber.shopStatus.startTime,
      'endTime': barber.shopStatus.endTime,
      'shopStatus': barber.shopStatus.status,
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}

Future<void> getAllBarbers(BuildContext context) async {
  final result = await FirebaseFirestore.instance.collection('Barbers').get();

  List<BarberModel> barberList = [];

  for (var data in result.docs) {
    BarberInfo barber = BarberInfo(
        barberId: data['barberId'],
        barberFullName: data['fullName'],
        barberEmail: data['email'],
        barberContact: data['contact'],
        roll: 'Barber',
        barberPassword: '');

    Location location = Location(
        address: data['address'],
        latitude: data['latitude'],
        longitude: data['longitude']);

    ShopStatus status = ShopStatus(
        status: data['shopStatus'],
        startTime: data['startTime'],
        endTime: data['endTime']);

    barberList.add(BarberModel(
        shopName: data['shopName'],
        barber: barber,
        seats: data['seats'],
        description: data['description'],
        rating: double.parse("${data['rating']}"),
        goodReviews: data['goodReviews'],
        totalScore: data['totalScore'],
        satisfaction: data['satisfaction'],
        image: data['image'],
        location: location,
        shopStatus: status));
  }
  Provider.of<DataManagerProvider>(context, listen: false)
      .setAllBarbers(barberList);
}

Future<void> getTopBarbers(BuildContext context) async {
  final result =
      await FirebaseFirestore.instance.collection('Top Barbers').get();

  List<BarberModel> topList = [];

  for (var data in result.docs) {
    BarberInfo barber = BarberInfo(
        barberId: data['barberId'],
        barberFullName: data['fullName'],
        barberEmail: data['email'],
        barberContact: data['contact'],
        roll: 'Barber',
        barberPassword: '');

    Location location = Location(
        address: data['address'],
        latitude: data['latitude'],
        longitude: data['longitude']);

    ShopStatus status = ShopStatus(
        status: data['shopStatus'],
        startTime: data['startTime'],
        endTime: data['endTime']);

    topList.add(BarberModel(
        shopName: data['shopName'],
        barber: barber,
        seats: data['seats'],
        description: data['description'],
        rating: double.parse("${data['rating']}"),
        goodReviews: data['goodReviews'],
        totalScore: data['totalScore'],
        satisfaction: data['satisfaction'],
        image: data['image'],
        location: location,
        shopStatus: status));
  }
  Provider.of<DataManagerProvider>(context, listen: false)
      .setTopBarbers(topList);
}

/////////////////////////Appointment
Future<void> setAppointment(AppointmentModel model) async {
  await FirebaseFirestore.instance.collection('Appointments').add({
    'customerId': model.customerId,
    'barberId': model.barberId,
    'seatNo': model.seatNo,
    'startTime': model.startTime,
    'endTime': model.endTime,
    'shopName': model.shopName,
    'shopAddress': model.shopAddress,
    'barberContact': model.barberContact,
    'status': model.appointmentStatus,
  });
}

Future<void> getAppointmentFromFirebase(
    String barberId, BuildContext context) async {
  final result = await FirebaseFirestore.instance
      .collection('Appointments')
      .where('barberId', isEqualTo: barberId)
      .get();
  List<AppointmentModel> app = [];
  for (var data in result.docs) {
    app.add(AppointmentModel(
        customerId: data['customerId'],
        barberId: data['barberId'],
        startTime: data['startTime'],
        endTime: data['endTime'],
        seatNo: data['seatNo'],
        appointmentStatus: data['status'],
        shopAddress: data['shopAddress'],
        shopName: data['shopName'],
        barberContact: data['barberContact']));
  }
  Provider.of<DataManagerProvider>(context, listen: false)
      .setAppointmentList(app);
}

Future<void> getMyAppointmentsFromFirebase(
    String myid, BuildContext context) async {
  final result = await FirebaseFirestore.instance
      .collection('Appointments')
      .where('customerId', isEqualTo: myid)
      .get();
  List<AppointmentModel> app = [];
  for (var data in result.docs) {
    app.add(AppointmentModel(
        customerId: data['customerId'],
        barberId: data['barberId'],
        startTime: data['startTime'],
        endTime: data['endTime'],
        seatNo: data['seatNo'],
        appointmentStatus: data['status'],
        shopAddress: data['shopAddress'],
        shopName: data['shopName'],
        barberContact: data['barberContact']));
  }
  Provider.of<DataManagerProvider>(context, listen: false)
      .setMyAppointments(app);
}

Future<void> getMyAppointmentWithBarberFromFirebase(
    String id, BuildContext context) async {
  try {
    final userProfile = await FirebaseFirestore.instance
        .collection('Barbers')
        .where('barberId', isEqualTo: id)
        .get();
    late BarberModel barbP;

    for (var data in userProfile.docs) {
      BarberInfo barber = BarberInfo(
          barberId: data['barberId'],
          barberFullName: data['fullName'],
          barberEmail: data['email'],
          barberContact: data['contact'],
          roll: 'Barber',
          barberPassword: '');

      Location location = Location(
          address: data['address'],
          latitude: data['latitude'],
          longitude: data['longitude']);

      ShopStatus status = ShopStatus(
          status: data['shopStatus'],
          startTime: data['startTime'],
          endTime: data['endTime']);

      barbP = BarberModel(
          shopName: data['shopName'],
          barber: barber,
          seats: data['seats'],
          description: data['description'],
          rating: double.parse("${data['rating']}"),
          goodReviews: data['goodReviews'],
          totalScore: data['totalScore'],
          satisfaction: data['satisfaction'],
          image: data['image'],
          location: location,
          shopStatus: status);
    }
    Provider.of<DataManagerProvider>(context, listen: false)
        .setMyAppointmentWithBarber(barbP);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
  }
}
