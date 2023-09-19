import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_rim/Consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'check_out.dart';
import '../models/salon_model/salon_model.dart';
import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/menu_boutton.dart';
import '../widgets_common/our_button.dart';
import 'SalonListScreen.dart';
import 'package:intl/intl.dart';

class ReserverSalon extends StatefulWidget {
  final String userType;
  final SalonModel salonModel;
  final List<Map<String, dynamic>> selectedServices;
  final num totalPrice;
   final String reservationId;

  ReserverSalon({required this.selectedServices, required this.totalPrice, required this.salonModel, required this.reservationId, required this.userType});

  @override
  _ReserverSalonState createState() => _ReserverSalonState();
}

class _ReserverSalonState extends State<ReserverSalon> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isAlreadyReserved = false;

  // Liste fictive de réservations existantes
  List<Map<String, dynamic>> existingReservations = [
    {
      'date': DateTime(2023, 7, 12),
      'time': TimeOfDay(hour: 10, minute: 00),
      'salon': 'Super Cut Salon',
    },
    {
      'date': DateTime(2023, 7, 13),
      'time': TimeOfDay(hour: 14, minute: 30),
      'salon': 'Rossano Ferretti Salon',
    },
    {
      'date': DateTime(2023, 7, 14),
      'time': TimeOfDay(hour: 16, minute:00),
      'salon': 'Neville Hair and Beauty',
    },
  ];

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        isAlreadyReserved = checkReservation(selectedDate, selectedTime);
      });
    }
  }

  void _selectTime() async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );

  if (pickedTime != null && pickedTime != selectedTime) {
    setState(() {
      // Round the selected time to the nearest 30-minute interval
      int minutes = (pickedTime.minute / 30).round() * 30;
      selectedTime = TimeOfDay(hour: pickedTime.hour, minute: minutes);
      isAlreadyReserved = checkReservation(selectedDate, selectedTime);
    });
  }
}


bool checkReservation(DateTime? date, TimeOfDay? time) {
  if (date != null && time != null) {
    for (var reservation in existingReservations) {
      if (reservation['date'].year == date.year &&
          reservation['date'].month == date.month &&
          reservation['date'].day == date.day &&
          reservation['time'].hour == time.hour &&
          (reservation['time'].minute / 30).round() ==
              (time.minute / 30).round()) {
        return true;
      }
    }
  }
  return false;
}


 

  void _makeReservation() async {
  if (selectedDate != null && selectedTime != null) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final TimeOfDayFormat timeFormatter = TimeOfDayFormat.HH_colon_mm;

    final DateTime selectedDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

 Map<String, dynamic> reservationData = {
      'date': dateFormatter.format(selectedDate!),
      'time': DateFormat.Hm().format(selectedDateTime),
      'salon': widget.salonModel.name,
      'userId': FirebaseAuth.instance.currentUser?.uid, 
      'userName': FirebaseAuth.instance.currentUser?.displayName,
    };
      if (widget.userType == "freelancer") {
      reservationData['adresse'] =addressController.text; 
    }

    final reservationRef =
        FirebaseFirestore.instance.collection('reservations').doc(widget.reservationId);
 List selectedServiceNames = widget.selectedServices.map((service) => service['name']).toList();

    await reservationRef.set({
       'id': reservationRef.id,
       'salonName': widget.salonModel.name,
       'selectedServices':selectedServiceNames,
      'totalePrice': widget.totalPrice.toString() ,
      'salonId': widget.salonModel.id,
      'date': dateFormatter.format(selectedDate!),
      'time': DateFormat.Hm().format(selectedDateTime),
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'userName': FirebaseAuth.instance.currentUser?.displayName,
      'isNotified':false,
      if (widget.userType == "freelancer") 'adresse': reservationData['adresse'],

    });

    print(widget.reservationId);
      await Get.to(() => Checkout( reservationData: reservationData,
      selectedServices: widget.selectedServices,
      totalPrice: widget.totalPrice,singleSalon:widget.salonModel,reservationId:reservationRef.id ,/*passer des données si nécessaire*/));

  }
}

TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
        
      ),
        drawer: 
      
      MenuBoutton(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            color: whiteColor.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                const Text(
                  'Vous avez choisi :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: BbRed,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.selectedServices.length,
                    itemBuilder: (context, index) {
                      final service = widget.selectedServices[index];
                      return ListTile(
                        title: Text(
                          service['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          ' ${service['price']} DH',
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Prix total:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${widget.totalPrice} DH',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 20),
                Visibility(
            visible: widget.userType == "freelancer",
            child: Column(
              children: [
                Text(
                  'Adresse:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: addressController,
                /*  onChanged: (address) {
                   addressController.text=address;
                  },*/
                  decoration: InputDecoration(
                    hintText: 'Entrez votre adresse',
                  ),
                ),
              ],
            ),
            )
            ,
                Text(
                  'Jour:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  readOnly: true,
                  onTap: _selectDate,
                  decoration: InputDecoration(
                    hintText: selectedDate != null
                        ? selectedDate!.toString().split(' ')[0]
                        : 'Choisir une date',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Heure:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  readOnly: true,
                  onTap: _selectTime,
                  decoration: InputDecoration(
                    hintText: selectedTime != null
                        ? selectedTime!.format(context)
                        : 'Choisir une heure',
                  ),
                ),
                SizedBox(height: 40),
                if (isAlreadyReserved)
                  Column(
                    children: [
                   const Text(
                        'Cette date et heure sont déjà réservées.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                     const SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 45,
                              width: context.screenWidth - 107,
                              child: ourButton(
                                color: BbRed,
                                title: 'Changer la date',
                                onPress: () {
                                  setState(() {
                                    selectedDate = null;
                                    selectedTime = null;
                                    isAlreadyReserved = false;
                                  });
                                },
                              ),
                            ),
                          const   SizedBox(height: 20),
                            SizedBox(
                              height: 45,
                              width: context.screenWidth - 107,
                              child: ourButton(
                                color: BbRed,
                                title: 'Changer de salon',
                                onPress: 
                                () {
                                  Get.to(() => SalonListScreen(userType : widget.userType));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Center(
                    child: SizedBox(
                      height: 45,
                      width: context.screenWidth - 107,
                      child: ourButton(
                        color: BbRed,
                        //  textColor: Colors.white,
                        onPress: _makeReservation,
                        title: 'Réserver',
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
