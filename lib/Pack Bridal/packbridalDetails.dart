import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

import '../SalonsScreen/check_out.dart';
import '../models/salon_model/salon_model.dart';

class PackBridalDetails extends StatefulWidget {
  final String salonId;
  final String userType;

  PackBridalDetails({required this.salonId, required this.userType});

  @override
  _PackBridalDetailsState createState() => _PackBridalDetailsState();
}

class _PackBridalDetailsState extends State<PackBridalDetails> {
   TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)),
  );
  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
      dateController.text = DateFormat('yyyy-MM-dd').format(picked); // Format the date as 'yyyy-MM-dd'
    });
  }
}

TimeOfDay? selectedTime;

 Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null && picked != selectedTime) {
    // Créez un objet DateTime avec l'heure et les minutes de TimeOfDay
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );

    setState(() {
      selectedTime = picked;
      timeController.text = DateFormat('HH:mm').format(selectedDateTime); // Format the time as 'HH:mm'
      
    });
  }
  
}
Future<SalonModel> getSalonModel(String salonId) async {
  try {
    String collectionName="";
    widget.userType=="salons"? collectionName="salons":"freelancers";
    final salonDoc = await FirebaseFirestore.instance.collection(collectionName).doc(salonId).get();
    if (salonDoc.exists) {
      final salonData = salonDoc.data() as Map<String, dynamic>;

      // Créez un modèle de salon à partir des données récupérées
      final salonModel = SalonModel(
        // Assurez-vous d'adapter ces champs à votre modèle SalonModel
        name: salonData['name'],
        address: salonData['address'],
        image: salonData['image'],
        CartNumber: salonData['cartNumber'],
        email: salonData['email'],
        phone: salonData['phone'],
        isFavourite: false,
        id: salonData['id'],
        // Ajoutez d'autres champs si nécessaire
      );

      return salonModel;
    }
  } catch (e) {
    print("Erreur lors de la récupération du modèle de salon : $e");
  }
  return SalonModel(image: [], isFavourite: false, id: "id", name: "name", email: "email", phone: "phone", address: "address", CartNumber: "CartNumber"); // Retournez null en cas d'erreur ou si le salon n'existe pas
}



  String? selectedPackName;
  List<dynamic>? selectedServices;
  String selectedPrice="";
  DateTime? selectedDate;
List<Map<String, dynamic>> selectedsubServices = [];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails des packbridals'),
        backgroundColor: BbPink,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('packbridal')
            .where('salonId', isEqualTo: widget.salonId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final packbridals = snapshot.data!.docs;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: packbridals.length,
                  itemBuilder: (context, index) {
                    final packbridalData = packbridals[index].data() as Map<String, dynamic>;

                    final packName = packbridalData['packName'] as String;
                    final services = packbridalData['services'] as List<dynamic>;
                    final price = packbridalData['price'] as String;
    selectedsubServices = services.map((service) => {
      'name': service,
      'price':"price"
      // Ajoutez d'autres champs si nécessaire
    }).toList();
  
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedPackName = packName;
                          selectedServices = services;
                          selectedPrice = price;
                        });
                      },
                      child: Card(
                        margin: EdgeInsets.all(16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$packName -- $price DH',
                                style: TextStyle(fontWeight: FontWeight.w600, color: BbRed, fontSize: 20),
                              ),
                              SizedBox(height: 20),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: services.length,
                                itemBuilder: (context, serviceIndex) {
                                  final service = services[serviceIndex].toString();
                                  return Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text('Service ${serviceIndex + 1}: $service'),
                                  );
                                },
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (selectedPackName != null && selectedServices != null && selectedPrice != null)
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pack: $selectedPackName',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Prix: $selectedPrice DH'),
                              SizedBox(width: 70,),
                              Center(
                            child: SizedBox(
                              height: 45,
                              width: context.screenWidth - 200,
                              child: ourButton(
                                onPress: () async {
                               SalonModel   salonModel=await getSalonModel(widget.salonId);
                                  print(selectedServices);
                                  num Price = 0.0;
                                  Price = double.parse(selectedPrice); // Convertit une String en double
                                  // Handle reservation logic here
                                 try{ if (selectedDate != null && selectedTime != null) {
                                    // Construct the data and save it to Firestore
                                   String reservationId=FirebaseFirestore.instance.collection('reservations').doc().id;
                                    final reservationData = {
                                     'id':reservationId,
                                      'date': dateController.text, // Format as needed
                                      'salonId': widget.salonId,
                                      'salonName': await FirebaseFirestore.instance.collection(widget.userType=="salons"?'salons':'freelancers').doc(widget.salonId).get().then((doc) => doc['name']),
                                      'selectedServices': selectedServices,
                                      'isNotified':false
                                      /*!.map((service) {
                                        
                                        return {
                                          'name': service['name'],
                                          'price': selectedPrice,
                                        };
                                      }).toList()*/,
                                     'time': timeController.text,
                                     'totalePrice': Price,
                                     'userId': FirebaseAuth.instance.currentUser?.uid, 
                                     'userName': FirebaseAuth.instance.currentUser?.displayName, // Replace with actual user name
                                    };
                                      print(FirebaseFirestore.instance.collection('reservations').doc().id);
                                      print("**************");
                                    print(reservationId);
                                    FirebaseFirestore.instance.collection('reservations').doc(reservationId).set(reservationData);
                                    
                                    // Clear the selections and controllers
                                    setState(() {
                                      selectedPackName = null;
                                      selectedServices = null;
                                      selectedPrice = "";
                                      selectedDate = null;
                                      selectedTime = null;
                                      dateController.clear();
                                      timeController.clear();
                                    });

                                    // Show a success message to the user
                                    await ScaffoldMessenger.of(context).showSnackBar(
                                     //  await Get.to(() => Checkout( reservationData: reservationData,
                                      //selectedServices: widget.selectedServices,
                                      //totalPrice: widget.selectedPrice,singleSalon:widget.salonModel,reservationId:reservationRef.id ,/*passer des données si nécessaire*/));
                                      SnackBar(content: Text('Réservation effectuée avec succès')),
                                    );
                                    Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => Checkout(
      reservationData: reservationData,
      selectedServices: selectedsubServices,
      totalPrice: Price,
      singleSalon:salonModel, 
      reservationId: reservationId, // Assurez-vous d'avoir reservationId défini dans votre code
      // Vous pouvez également transmettre d'autres données si nécessaire
    ),
  ),
);

                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Veuillez sélectionner une date et une heure')),
                                    );
                                  }
                                 }catch(e) {print(e);}
                                },
                                title: 'Réserver',
                              ),
                            ),
                          ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('Services inclus:'),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: selectedServices!.length,
                              itemBuilder: (context, serviceIndex) {
                                final service = selectedServices![serviceIndex].toString();
                                return Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Text('Service ${serviceIndex + 1}: $service'),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                           TextFormField(
                            controller: dateController,
                            decoration: InputDecoration(labelText: 'Date (yyyy-mm-dd)'),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          TextFormField(
                            controller: timeController,
                            decoration: InputDecoration(labelText: 'Heure (hh:mm)'),
                            onTap: () {
                              _selectTime(context);
                            },
                          ),
                          20.heightBox,
                          
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
