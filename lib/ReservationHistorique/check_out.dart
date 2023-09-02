import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';


import '../../provider/app_provider.dart';
import '../../stripe_helper/stripe_helper.dart';
import '../SalonsScreen/SalonListScreen.dart';
import '../models/salon_model/salon_model.dart';

class Checkout extends StatefulWidget {
  final SalonModel singleSalon;
    final Map<String, dynamic> reservationData;
  final List<Map<String, dynamic>> selectedServices;
  final num totalPrice;
  const Checkout({super.key, required this.singleSalon, required this.reservationData, required this.selectedServices, required this.totalPrice});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Future<void> saveReservationData() async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    
    Map<String, dynamic> reservation = {
      "salonName": widget.singleSalon.name,
      'services': widget.selectedServices,
      'totalPrice': widget.totalPrice,
      'date': widget.reservationData['date'],
      'time': widget.reservationData['time'],
      // Ajoutez d'autres informations que vous souhaitez enregistrer
    };

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid; // Obtenez l'ID de l'utilisateur connecté à partir de votre système d'authentification
      await FirebaseFirestore.instance.collection('userReservations').doc(userId).collection('reservations').add(reservation);
      print('Reservation data saved successfully.');
    } catch (error) {
      print('Error saving reservation data: $error');
    }
  }
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BbPink,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 36.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: BbRed, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Paiement sur place",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: BbRed, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Paiement en ligne",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Center(
              child: SizedBox(
                height: 45,
                              width: context.screenWidth - 107,
                child: ourButton(
                  title: "Continues",
                  onPress: () async {
              
                    if (groupValue == 1) {
                      bool value=await FirebaseFirestoreHelper.instance.uploadSalonReserveFirebase(widget.selectedServices,context,"Paiement sur place",widget.totalPrice.toString());
                      if(value){
                         Future.delayed(const Duration(seconds: 2), () {
                                 Get.to(() => SalonListScreen(userType : "client"));

                    });
                      }
                             //  await saveReservationData(); 
                     
                    } else {
                      int value = widget.totalPrice
                          .round()
                          .toInt();
                      String totalPrice = (10*value).toString();
                      await StripeHelper.instance
                          .makePayment(widget.selectedServices,totalPrice.toString(), context);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
