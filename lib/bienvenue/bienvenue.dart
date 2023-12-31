import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../SalonsScreen/SalonListScreen.dart';
import 'dart:async';

class BienvenueScreen extends StatefulWidget {
  final String userType;
  const BienvenueScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<BienvenueScreen> createState() => _BienvenueScreenState();
}

class _BienvenueScreenState extends State<BienvenueScreen> {
  @override
  void initState() {
    super.initState();
   redirectToSalonListScreen();
  }

  void redirectToSalonListScreen() {
   Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SalonListScreen(userType:widget.userType),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: 500,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgimg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                     // const SizedBox(height: 50),
                     // boldText(text: "Bienvenue ", color: BbRed, size: 50),
                     // boldText(text: "Chez ", color: BbRed, size: 50),
                      Image.asset(
                        "assets/bienvenue.png",
                        fit: BoxFit.contain,
                        height: 503,
                        width: 345,
                      ).box.make(),
                    ],
                  ).box
                      .width(300)
                      .height(520)
                  .color(Colors.white.withOpacity(0.5))
                      .rounded
                      .padding(const EdgeInsets.all(8))
                      .make(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
