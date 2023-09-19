import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_rim/Consts/colors.dart';
import 'package:app_rim/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:app_rim/widgets_common/our_button.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';


import '../../provider/app_provider.dart';
import '../../stripe_helper/stripe_helper.dart';
import '../NotificationApi.dart';
import 'SalonListScreen.dart';
import '../models/salon_model/salon_model.dart';

class Checkout extends StatefulWidget {
  final String reservationId;
  final SalonModel singleSalon;
    final Map<String, dynamic> reservationData;
  final List<Map<String, dynamic>> selectedServices;
  final num totalPrice;
  const Checkout({super.key, required this.singleSalon, required this.reservationData, required this.selectedServices, required this.totalPrice, required this.reservationId});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Future<void> _scheduleNotificationForSalon(String userId) async {
  final QuerySnapshot<Map<String, dynamic>> reservationsSnapshot =
      await FirebaseFirestore.instance
          .collection('reservations')
          .where('userId', isEqualTo: userId)
          .where('isNotified', isEqualTo: false)
          .get();
    print(reservationsSnapshot);
  for (final QueryDocumentSnapshot<Map<String, dynamic>> reservationSnapshot
      in reservationsSnapshot.docs) {
    final String dateString = reservationSnapshot['date'] as String;
    print(dateString);
    final String timeString = reservationSnapshot['time'] as String;
   print(timeString);
    // Convert the date and time to DateTime objects
    final List<String> dateParts = dateString.split('-');
    final List<String> timeParts = timeString.split(':');
    final int year = int.parse(dateParts[0]);
    final int month = int.parse(dateParts[1]);
    final int day = int.parse(dateParts[2]);
    final int hours = int.parse(timeParts[0]);
    final int minutes = int.parse(timeParts[1]);

    final DateTime reservationTime = DateTime(year, month, day, hours, minutes);
    print(reservationTime);
    print("heure maintenannt est ${DateTime.now()}" );
NotificationApi.showScheduledNotification(
      title: 'Confirmation de réservation',
      body: 'Avez-vous bénéficié du service ?',
      payload: 'Avez vous bénéficié du service',
      scheduledDate: reservationTime.add(const Duration(hours: 1))
    );

     await FirebaseFirestore.instance
          .collection('reservations')
          .doc(reservationSnapshot.id)
          .update({'isNotified': true});
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
          "Caisse",
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
                    _scheduleNotificationForSalon(FirebaseAuth.instance.currentUser!.uid);
              print(widget.reservationId);
                    if (groupValue == 1) {
                      bool value=await FirebaseFirestoreHelper.instance.uploadSalonReserveFirebase(widget.selectedServices,context,"Paiement sur place",widget.totalPrice.toString(),widget.reservationId);
                      if(value){
                         Future.delayed(const Duration(seconds: 2), () {
                                 Get.to(() => SalonListScreen(userType : "salons"));

                    });
                      }
                             //  await saveReservationData(); 
                     
                    } else {
                      int value = widget.totalPrice
                          .round()
                          .toInt();
                      String totalPrice = (100*value).toString();
                      await StripeHelper.instance
                          .makePayment(widget.selectedServices,totalPrice, context,widget.reservationId);
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
