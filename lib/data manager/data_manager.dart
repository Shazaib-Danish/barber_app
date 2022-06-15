import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:gromify/model/barber_model.dart';
import 'package:gromify/model/data.dart';
import 'package:gromify/model/user_model.dart';

import '../model/appointment_model.dart';

class DataManagerProvider extends ChangeNotifier {
  bool isLoading = false;

  late List<BarberModel> allBarbers;
  late List<BarberModel> topBarbers;

  List<BarberModel> searchList = [];

  late BarberInfo barberInfo;

  late BarberModel barberCompleteData;

  late CustomerInfo customerProfile;

  late BarberModel barberProfile;

  late bool isSearching = false;

  late List<AppointmentModel> myAppointments = [];

  late BarberModel myAppointmentWithBarber;

  List<AppointmentModel> appointmentList = [];

  void setLoadingStatus(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  bool get loading => isLoading;

  void setCustomerProfile(CustomerInfo user) {
    customerProfile = user;
    notifyListeners();
  }

  CustomerInfo get currentUser => customerProfile;

  void setBarberProfile(BarberModel user) {
    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    barberProfile = user;
    notifyListeners();
  }

  BarberModel get getBarberProfile => barberProfile;

  void setAllBarbers(List<BarberModel> barberMapList) {
    allBarbers = barberMapList;
    notifyListeners();
  }

  List<BarberModel> get getAllBarbers => allBarbers;

  void setTopBarbers(List<BarberModel> barberTopList) {
    topBarbers = barberTopList;
    notifyListeners();
  }

  List<BarberModel> get getTopBarbers => topBarbers;

  void getSearch(String searchKey) {
    allBarbers.forEach((element) {
      if (element.shopName.toLowerCase().startsWith(searchKey.toLowerCase()) ||
          element.shopName.startsWith(searchKey.toLowerCase())) {
        searchResult(element);
      }
    });
  }

  void searchResult(BarberModel barberModel) {
    searchList.add(barberModel);
    notifyListeners();
  }

  List<BarberModel> get getSearchList => searchList;

  void setIsSearching(bool value) {
    isSearching = value;
    notifyListeners();
  }

  bool get searchingStart => isSearching;

  void setBarberBasicInformation(
      String id, String name, String email, String contact) {
    barberInfo = BarberInfo(
        barberId: id,
        barberFullName: name,
        barberEmail: email,
        barberContact: contact,
        roll: 'Barber',
        barberPassword: '');
    notifyListeners();
  }

  void setBarberShopInfo(
      String shopName,
      String seats,
      String description,
      String address,
      double latitude,
      double longitude,
      String startTime,
      String endTime) {
    Location location =
        Location(address: address, latitude: latitude, longitude: longitude);
    ShopStatus status =
        ShopStatus(status: 'Open', startTime: startTime, endTime: endTime);
    final _random = Random();
    String index = urls[_random.nextInt(urls.length)];
    barberCompleteData = BarberModel(
        shopName: shopName,
        barber: barberInfo,
        seats: seats,
        description: description,
        rating: 0.0,
        goodReviews: 0,
        totalScore: 0,
        satisfaction: 0,
        image: index,
        location: location,
        shopStatus: status);
    notifyListeners();
  }

  BarberModel get getBarberDetails => barberCompleteData;

/////////////////appointment
  void setAppointmentList(List<AppointmentModel> model) {
    appointmentList = model;
    notifyListeners();
  }

  void setMyAppointments(List<AppointmentModel> model) {
    myAppointments = model;
    notifyListeners();
  }

  void setMyAppointmentWithBarber(BarberModel barberModel){
    myAppointmentWithBarber = barberModel;
    notifyListeners();
  }

}
