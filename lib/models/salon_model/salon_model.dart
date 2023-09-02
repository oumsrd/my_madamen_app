import 'dart:convert';

SalonModel salonModelFromJson(String str) => SalonModel.fromJson(json.decode(str));

String salonModelToJson(SalonModel data) => json.encode(data.toJson());

class SalonModel {
  SalonModel({
    required this.image,
        required this.isFavourite,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.CartNumber,
    

  });

 List<dynamic> image;
   bool isFavourite;
  String name;
  String email;
  String phone;
  String address;
  String CartNumber;

  String id;

  factory SalonModel.fromJson(Map<String, dynamic> json) => SalonModel(
        id: json["id"],
        image: json["image"],
        isFavourite: false,
        email: json["email"],
        name: json["name"], 
        CartNumber: json["cartNumber"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
       "isFavourite": isFavourite,
        "name": name,
        "email": email,
        "phone":phone,
        "address": address,
        "cartNumber": CartNumber,
        
      };

  SalonModel copyWith({
    String? name,
    image,
    address,
  }) =>
      SalonModel(
        id: id,
        name: name ?? this.name,
        email: email,
        image: image ?? this.image,
        isFavourite: isFavourite,
        phone: phone,
        address: address,
        CartNumber: CartNumber,
      );
}
