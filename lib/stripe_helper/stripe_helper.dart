
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_madamn_app/Consts/const.dart';
import 'package:provider/provider.dart';


import '../SalonsScreen/SalonListScreen.dart';
import '../constants/constants.dart';
import '../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../provider/app_provider.dart';

class StripeHelper {
  static StripeHelper instance = StripeHelper();

  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment( List<Map<String, dynamic>> selectedServices,String amount, BuildContext context,String reservationId)async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'MAD');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "MA", currencyCode: "MAD", testEnv: true
          );

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Oumeyma',
                  googlePay: gpay))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(selectedServices,context,amount,reservationId);
    } catch (err) {
      showMessage(err.toString());
    }
  }

  displayPaymentSheet(List<Map<String, dynamic>> selectedServices,BuildContext context,String price,String reservationId)async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
      bool value = await FirebaseFirestoreHelper.instance.uploadSalonReserveFirebase(  selectedServices, context, "Paid",price,reservationId);

      //  appProvider.clearBuyProduct();
        if (value) {
          Future.delayed(const Duration(seconds: 2), () {
                  Get.to(() => SalonListScreen(userType : "salons"));
          }
          );
        }
      });
    } catch (e) {
      showMessage(e.toString());
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer $SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
   Future<void> registerCard(BuildContext context) async {
    try {
      String cardNumber = ''; // Initialize with empty string
      String expirationDate = ''; // Initialize with empty string

      // Show a dialog to collect card information
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Register Card'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Card Number'),
                  onChanged: (value) {
                    cardNumber = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Expiration Date'),
                  onChanged: (value) {
                    expirationDate = value;
                  },
                ),              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context); // Close the dialog
                  await saveCardInformation(cardNumber, expirationDate);
                },
                child: Text('Register'),
              ),
            ],
          );
        },
      );
    } catch (err) {
      showMessage(err.toString());
    }
  }

  Future<void> saveCardInformation(
    String cardNumber,
    String expirationDate,
  ) async {
    try {
      // Assuming you have a reference to the Firestore collection document
      // where you want to store the card information.
      // Replace 'salons' with the appropriate collection name.
      DocumentReference salonDocument =
          FirebaseFirestore.instance.collection('salons').doc('documentId');

      // Update the 'cartNumber' and 'expirationDate' fields in the Firestore document
      await salonDocument.update({
        'cartNumber': cardNumber,
       // 'expirationDate': expirationDate,
        // Update other card-related fields here if needed.
      });

      // Display a success message or navigate to the next screen.
      showMessage('Card registered successfully');
    } catch (err) {
      showMessage(err.toString());
    }
  }
}
