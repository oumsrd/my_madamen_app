import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/auth_screen/SignUp/chosescreen.dart';
import 'package:my_madamn_app/auth_screen/SignUp/signup_screen.dart';
//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';
import 'AddServices.dart';

class SalonServices extends StatefulWidget {
  const SalonServices({super.key});

  @override
  State<SalonServices> createState() => _SalonServicesState();
}

class _SalonServicesState extends State<SalonServices> {
  TextEditingController villeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> selectedPhotos = [];

  List<String> services = ["Service Chevelure", "Onglerie", "Facial", "Corporel"];
  List<int> personnelCount = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgimg.jpg"),
              fit: BoxFit.cover, 
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              
              child: Column(
                children: [
                  Container(
                    width: 500,
                    child: Image.asset(
                      "assets/madamen.png",
                      fit: BoxFit.contain,
                      height: 200,
                    ).box.width(200).height(250).make(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          6.heightBox,
                         
                         
                          SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: services.length,
                            itemBuilder: (context, index) {
                              final service = services[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(service, style: TextStyle(fontSize: 16)),
                                    SizedBox(
                                      width: 100,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "Personnel",
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: BbRed),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: BbRed),
                                          ),
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                        ),
                                        onChanged: (value) {
                                          int count = int.tryParse(value) ?? 0;
                                          setState(() {
                                            personnelCount[index] = count;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 60),
                          SizedBox(
                            height: 45,
                            width: context.screenWidth - 107,
                            child: ourButton(
                              color: BbRed,
                              title: "Continuer",
                              onPress: () async {
                                Get.to(
                                  AddService(
                                    services: services,
                                    personnelCount: personnelCount,
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      ).box
                          .width(300)
                          .height(800)
                          .color(Colors.white.withOpacity(0.5))
                          .rounded
                          .padding(const EdgeInsets.all(8))
                          .make(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
