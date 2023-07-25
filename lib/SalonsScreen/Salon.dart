class Salon {
  final String name;
  final String imageURL;
  final String adresse;

  Salon({required this.adresse, required this.name, required this.imageURL});
}
final List<Salon> salonData = [
  Salon(name: "Hoda Beauty", imageURL: "assets/salon1.png",adresse: "Sidi Abbad"),
  Salon(name: "Beauty & Cosmetics", imageURL: "assets/stylist2.jpg",adresse:'Gueliz'),
  Salon(name: "Hair & Beauty", imageURL: "assets/salon3.jpg",adresse: "Issil"),
  // Add more salon data as needed
];