import 'dart:convert';


ServiceModel serviceModelFromJson(String str) => ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  ServiceModel({
   // required this.id,
    required this.name,
    required this.image,
    required this.nombre_personnels, 

  });

  String image;
  String name;
  String nombre_personnels;
 

 // String id;
  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
       // id: json["id"],
        image: json["image"],
         name: json["name"], 
        nombre_personnels: json["nombre_personnels"], 

       
      );

  Map<String, dynamic> toJson() => {
    //    "id": id,
        "name": name,
        "image": image,
        "nombre_personnels": nombre_personnels,
       
        
      };

  ServiceModel copyWith({
    String? name,
    image,
    nombre_personnels
  }) =>
      ServiceModel(
      //  id: id,
        name: name ?? this.name,
        image: image,
        nombre_personnels:nombre_personnels,
      );
}
