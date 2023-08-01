import 'dart:convert';

SalonModel userModelFromJson(String str) => SalonModel.fromJson(json.decode(str));

String userModelToJson(SalonModel data) => json.encode(data.toJson());

class SalonModel {
  SalonModel({
    this.image,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.CartNumber,
    

  });

  String? image;
  String name;
  String email;
  String phone;
  String address;
  String CartNumber;

  String id;

  factory SalonModel.fromJson(Map<String, dynamic> json) => SalonModel(
        id: json["id"],
        image: json["image"],
        email: json["email"],
        name: json["name"], 
        CartNumber: json["cartNumber"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
        "phone":phone,
        "address": address,
        "cartNumber": CartNumber,
        
      };

  SalonModel copyWith({
    String? name,
    image,
  }) =>
      SalonModel(
        id: id,
        name: name ?? this.name,
        email: email,
        image: image ?? this.image,
        phone: phone,
        address: address,
        CartNumber: CartNumber,
      );
}
