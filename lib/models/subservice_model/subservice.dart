import 'dart:convert';

SubServiceModel subserviceModelFromJson(String str) => SubServiceModel.fromJson(json.decode(str));

String subserviceModelToJson(SubServiceModel data) => json.encode(data.toJson());

class SubServiceModel {
  String? image ;
  String name;
 // String id;
  String price;
  String nombre_personnels;

 
  SubServiceModel({
    required this.image,
   // required this.id,
    required this.name,
    required this.price,
    required this.nombre_personnels
   
    

  });

 
  factory SubServiceModel.fromJson(Map<String, dynamic> json) => SubServiceModel(
      //  id: json["id"],
        image: json["image"],
        name: json["name"], 
        price: json["price"],
        nombre_personnels: json["nombre_personnels"],
       
      );

  Map<String, dynamic> toJson() => {
       // "id": id,
        "image": image,
        "name": name,
        "price": price,
        "nombre_personnels":nombre_personnels
       
        
      };

  SubServiceModel copyWith({
    String? name,
    image,
  }) =>
      SubServiceModel(
       // id: id,
        name: name ?? this.name,
        image: image ?? this.image,
        price: price,
        nombre_personnels: nombre_personnels 

      );
}
