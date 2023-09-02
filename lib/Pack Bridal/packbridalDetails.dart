import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class PackBridalDetails extends StatefulWidget {
  final String salonId;

  PackBridalDetails({required this.salonId});

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
      dateController.text = DateFormat('yyyy-MM-dd').format(picked); // Format the date
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
    setState(() {
      selectedTime = picked;
      timeController.text = picked.format(context);
    });
  }
}

  String? selectedPackName;
  List<dynamic>? selectedServices;
  String? selectedPrice;
  DateTime? selectedDate;

  
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
                                  print(selectedServices);
                                  // Handle reservation logic here
                                  if (selectedDate != null && selectedTime != null) {
                                    // Construct the data and save it to Firestore
                                    final reservationData = {
                                      'id':FirebaseFirestore.instance.collection('reservations').doc().id,
                                      'date': selectedDate!.toString(), // Format as needed
                                      'salonId': widget.salonId,
                                      'salonName': await FirebaseFirestore.instance.collection('salons').doc(widget.salonId).get().then((doc) => doc['name']),
                                      'selectedServices': selectedServices/*!.map((service) {
                                        return {
                                          'name': service['name'],
                                          'price': selectedPrice,
                                        };
                                      }).toList()*/,
                                     'time': selectedTime!.format(context),
                                     'totalePrice': selectedPrice,
                                     'userId': FirebaseAuth.instance.currentUser?.uid, 
                                     'userName': FirebaseAuth.instance.currentUser?.displayName, // Replace with actual user name
                                    };

                                    FirebaseFirestore.instance.collection('reservations').add(reservationData);

                                    // Clear the selections and controllers
                                    setState(() {
                                      selectedPackName = null;
                                      selectedServices = null;
                                      selectedPrice = null;
                                      selectedDate = null;
                                      selectedTime = null;
                                      dateController.clear();
                                      timeController.clear();
                                    });

                                    // Show a success message to the user
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Réservation effectuée avec succès')),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Veuillez sélectionner une date et une heure')),
                                    );
                                  }
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
