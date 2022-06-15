class BarberModel {
  String shopName;
  BarberInfo barber;
  String seats;
  String description;
  double rating;
  int goodReviews;
  int totalScore;
  int satisfaction;
  String image;
  Location location;
  ShopStatus shopStatus;

  BarberModel(
      {required this.shopName,
      required this.barber,
      required this.seats,
      required this.description,
      required this.rating,
      required this.goodReviews,
      required this.totalScore,
      required this.satisfaction,
      required this.image,
      required this.location,
      required this.shopStatus});
}

class BarberInfo {
  final String barberId;
  final String barberFullName;
  final String barberEmail;
  final String barberContact;
  final String barberPassword;
  final String roll;

  BarberInfo(
      {required this.barberId,
      required this.barberFullName,
      required this.barberEmail,
      required this.barberContact,
      required this.roll,
      required this.barberPassword});
}

class Location {
  final String address;
  final double latitude;
  final double longitude;

  Location({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class ShopStatus {
  final String startTime;
  final String endTime;
  final String status;

  ShopStatus(
      {required this.status, required this.startTime, required this.endTime});
}
