import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colo,
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
            "  EXPRESS SHOP is a leading mobile ecommerce platform, offering a seamless and convenient online shopping experience. Our user-friendly app allows you to browse and purchase a wide range of products with ease. With secure payment options and fast delivery, we strive to exceed your expectations and make online shopping enjoyable. Discover a diverse selection of products across various categories, including fashion, electronics, home decor, and more. Our intuitive interface ensures easy navigation, while personalized recommendations help you find products that match your preferences. We prioritize secure payments with robust encryption and reliable payment gateways, offering multiple options such as credit cards, digital wallets, and cash on delivery. Rest assured, our extensive network of delivery partners ensures prompt and reliable delivery, with real-time tracking updates to keep you informed. Our dedicated customer support team is available to assist you with any inquiries or concerns. At EXPRESS SHOP, we are committed to providing high-quality products at competitive prices. Join us today and redefine your online shopping experience. Download our mobile app now and experience the convenience and joy of effortless ecommerce."),
      ),
    );
  }
}
