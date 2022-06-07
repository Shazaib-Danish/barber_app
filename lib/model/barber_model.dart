import 'dart:convert';

class BarberModel {
    String shopName;
    String barberName;
    String barberContact;
    String seats;
    String description;
    double rating;
    double goodReviews;
    double totalScore;
    double satisfaction;
    bool isfavourite;
    String image;
    String address;

    BarberModel({
        required this.shopName,
        required this.barberName,
        required this.barberContact,
        required this.seats,
        required this.description,
        required this.rating,
        required this.goodReviews,
        required this.totalScore,
        required this.satisfaction,
        required this.isfavourite,
        required this.image,
        required this.address,
    });

    BarberModel copyWith({
        required String shopName,
        required String barberName,
        required String barberContact,
        required String seats,
        required String description,
        required double rating,
        required double goodReviews,
        required double totalScore,
        required double satisfaction,
        required bool isfavourite,
        required String image,
        required String address,
    }) => 
        BarberModel(
            shopName: shopName,
            barberName: barberName,
            barberContact: barberContact,
            seats: seats,
            description: description,
            rating: rating,
            goodReviews: goodReviews,
            totalScore: totalScore,
            satisfaction: satisfaction,
            isfavourite: isfavourite,
            image: image,
            address: address,
        );

    factory BarberModel.fromRawJson(String str) => BarberModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BarberModel.fromJson(Map<String, dynamic> json) => BarberModel(
        shopName: json["shopName"] == null ? null : json["shopName"],
        barberName: json["barberName"] == null ? null : json["barberName"],
        barberContact: json["barberContact"] == null ? null : json["barberContact"],
        seats: json["totalSeats"],
        description: json["description"] == null ? null : json["description"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        goodReviews: json["goodReviews"] == null ? null : json["goodReviews"].toDouble(),
        totalScore: json["totalScore"] == null ? null : json["totalScore"].toDouble(),
        satisfaction: json["satisfaction"] == null ? null : json["satisfaction"].toDouble(),
        isfavourite: json["isfavourite"] == null ? null : json["isfavourite"],
        image: json["image"] == null ? null : json["image"],
        address: json["address"] == null ? null : json["address"],
    );

    Map<String, dynamic> toJson() => {
        "shopName": shopName == null ? null : shopName,
        "barberName": barberName == null ? null : barberName,
        "barberContact": barberContact == null ? null : barberContact,
        "totalSeats": seats == null ? null : seats,
        "description": description == null ? null : description,
        "rating": rating == null ? null : rating,
        "goodReviews": goodReviews == null ? null : goodReviews,
        "totalScore": totalScore == null ? null : totalScore,
        "satisfaction": satisfaction == null ? null : satisfaction,
        "isfavourite": isfavourite == null ? null : isfavourite,
        "image": image == null ? null : image,
        "address": address == null ? null : image,
    };
}
