

import 'package:flutter/cupertino.dart';
import 'package:gromify/model/barber_model.dart';
import 'package:gromify/model/user_model.dart';

class DataManagerProvider extends ChangeNotifier{
  bool isLoading = false;

  late List<BarberModel> allBarbers;

  List<BarberModel> searchList = [];
  
  late UserInformation userData;

  late bool isSearching = false;

  void setLoadingStatus(bool loading){
    isLoading = loading;
    notifyListeners();
  }

  bool get loading => isLoading;
  
  void setUserProfile(UserInformation user){
    userData = user;
    notifyListeners();
  }

  UserInformation get currentUser => userData;

  void setAllBarbers(List<BarberModel> barberMapList){
    allBarbers = barberMapList;
    notifyListeners();
  }

  List<BarberModel> get getAllBarbers => allBarbers;

  void getSearch(String searchKey){
    allBarbers.forEach((element) {
      if(element.shopName.toLowerCase().startsWith(searchKey.toLowerCase()) ||element.shopName.startsWith(searchKey.toLowerCase()) ){
        searchResult(element);
      }
    });
  }
  void searchResult(BarberModel barberModel){
    searchList.add(barberModel);
    notifyListeners();
  }

  List<BarberModel> get getSearchList=> searchList;

  void setIsSearching(bool value){
    isSearching = value;
    notifyListeners();
  }

  bool get searchingStart => isSearching;
}