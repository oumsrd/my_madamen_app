import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_rim/auth_screen/SignUp/chosescreen.dart';
import 'package:app_rim/auth_screen/SignUp/signup_screen.dart';
//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../../models/salon_model/salon_model.dart';
import '../../models/service_model/service_model.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';
import '../../Salon/AddServices.dart';

class SalonServices extends StatefulWidget {
  //final SalonModel salonModel;
  const SalonServices({super.key, /*required this.salonModel*/});

  @override
  State<SalonServices> createState() => _SalonServicesState();
}

class _SalonServicesState extends State<SalonServices> {
   List<ServiceModel> serviceModelList = [];

  bool isLoading = false;
  void getServiceList() async {
    setState(() {
      isLoading = true;
    });
    serviceModelList = await FirebaseFirestoreHelper.instance
        .getServices();

    serviceModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }
   @override
  void initState() {
    getServiceList();
    super.initState();
  }
  TextEditingController villeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nombre_personnelsController= TextEditingController();


  List<String> selectedPhotos = [];

  //List<String> services = ["Service Chevelure", "Onglerie", "Facial", "Corporel"];
  //List<int> personnelCount = [0, 0, 0, 0];

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
                  20.heightBox,
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
                            itemCount: serviceModelList.length,
                            itemBuilder: (context, index) {
                             // final service = services[index];
                             ServiceModel singleService = serviceModelList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text( singleService.name, style: TextStyle(fontSize: 16)),
                                    SizedBox(
                                      width: 100,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: nombre_personnelsController,
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
                                           // personnelCount[index] = count;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            height: 45,
                            width: context.screenWidth - 107,
                            child: ourButton(
                              color: BbRed,
                              title: "Continuer",
                              onPress: () async {
                                print(nombre_personnelsController.text);
                                try{ 
         /*  await FirebaseFirestore.instance
          .collection('salons')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({'nombre_personnels':nombre_personnelsController.text });
          print("success");*/
          DocumentReference documentReference =FirebaseFirestore.instance
          .collection("salons")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("services")

          .doc();
          documentReference.set({'nombre_personnels':nombre_personnelsController.text });
}

          catch(e){print(e.toString());}
        
                               /* Get.to(

                                  AddService(
                                    services: services,
                                    personnelCount: personnelCount,
                                  ),
                                );*/
                              }
                            ),
                          ),
                        ],
                      ).box
                          .width(300)
                          .height(850)
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
