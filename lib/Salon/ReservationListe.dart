import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_madamn_app/widgets_common/menu.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import '../Consts/colors.dart';
import '../constants/constants.dart';


class ReservationList extends StatefulWidget {
  final String userType;

  const ReservationList({Key? key, required this.userType}) : super(key: key);
  @override
  State<ReservationList> createState() => _ReservationListState();
}
class _ReservationListState extends State<ReservationList> {
  bool paymentConfirmed = false; // Initialisez le paiement à "non confirmé" par défaut
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
 String? _firstName = "";
 String image='';
  List<Map<String, dynamic>> _reservations = [];

  @override
  void initState() {
    _loadUserData();
    _loadSalonReservations();
    super.initState();
    
  }

 Future<void> _loadUserData() async {
  try {
    User? user = _auth.currentUser;
    String userId = user!.uid;
    String collectionName='';
    widget.userType=="freelancer"?  collectionName="freelancers" :widget.userType=="salons"? collectionName="salons":collectionName="";
    DocumentSnapshot docSnapshot = await _firestore
        .collection(collectionName)
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      setState(() {
        _firstName = docSnapshot['name'];
        image=docSnapshot['image'][0];
      });
    } else {
      print('Document does not exist');
    }
  } catch (e) {
    print('Error fetching user data: $e');
  }
}
  Future<void> _loadSalonReservations() async {
  try {
    User? user = _auth.currentUser;
    String userId = user!.uid;
    QuerySnapshot reservationSnapshot = await _firestore
        .collection('reservations')
        .where('salonId', isEqualTo: userId)
        .get();

    for (QueryDocumentSnapshot doc in reservationSnapshot.docs) {
      final reservationId = doc.id;
      final statusDoc = await _firestore
          .collection('userReservation')
          .doc(reservationId)
          .get();

      final payment = statusDoc['payment'] as String;

      if (payment == 'Paid') {
        setState(() {
          paymentConfirmed = true;
        });
      }
    }

    List<Map<String, dynamic>> reservations = reservationSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // Tri des réservations par ordre décroissant de la date et de l'heure
    reservations.sort((a, b) {
      DateTime dateA = DateTime.parse(a['date'] + ' ' + a['time']);
      DateTime dateB = DateTime.parse(b['date'] + ' ' + b['time']);
      return dateA.compareTo(dateB);
    });

    setState(() {
      _reservations = reservations;
    });
  } catch (e) {
    print('Error fetching salon reservations: $e');
  }
}


Future<void> confirmPaymentForReservation(String reservationId) async {
  try {
    await FirebaseFirestore.instance
        .collection('userReservation')
        .doc(reservationId)
        .update({'payment': 'Paid'}); 
        setState(() {
          paymentConfirmed=true;  
        });

    _loadSalonReservations();
  } catch (e) {
    print('Erreur lors de la confirmation du paiement : $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BbRed,
    actions: [
    ],
  ),
  drawer: Menu(context,widget.userType),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
Row(
  children: [
    CircleAvatar(
      radius: 25,
     backgroundImage:   NetworkImage(image)
         
    ),
    SizedBox(width: 10),
    Text(
      '$_firstName',
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
    ),
    SizedBox(width: 9,),
    ourButton(
  title: 'Ajouter réservation',
  onPress: () {
    print(_firstName);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddReservationDialog(userType: widget.userType,);
      },
    );
  },
  ),
  ],
  ),
            SizedBox(height: 20),
            Text(
              'Réservations:',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _reservations.length,
                itemBuilder: (context, index) {
                  final reservation = _reservations[index];

                  final selectedServices =
                      reservation['selectedServices'] ;
                  final userName=reservation['userName'] ;    
                  final date = reservation['date'] ;
                  final time = reservation['time'] ;
                  final salon = reservation['salonName'];
                  final price=reservation['totalPrice'] ;
                 
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'Date: $date',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const  SizedBox(height: 10),
                           Text(
                            'Heure: $time',
                            style:const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                           SizedBox(height: 10),

                           Text(
                            'Cliente: $userName',
                            style: const TextStyle(
                            //  fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                         
                         
                          
                           SizedBox(height: 10),
                          
                           Text(
                          "Prix total: $price  DH",
                            style:  TextStyle(
                             // fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),

                          const Text(
                            'Services:',
                            style:  TextStyle(
                             // fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          //SizedBox(height: 5),
                         Column(
                        children: selectedServices
                      .map<Widget>(
                          (service) => ListTile(
                    title: Text(
                    service,
                   style:const TextStyle(
                    fontWeight: FontWeight.w500,
                  fontSize: 14,
                      ),
                 ),
                 
                 
              /* subtitle: Text(
                  ' ${service['totalPrice']} DH',
              style: const TextStyle(
              fontSize: 12,
            ),
          ),*/
        ),
      )
      .toList(),
      
),
Text(
          paymentConfirmed ? 'Paiement confirmé' : 'Paiement non confirmé',
          style: TextStyle(
            color: paymentConfirmed ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            String reservationId=reservation['id'];
            // Confirmer le paiement pour cette réservation
            await confirmPaymentForReservation(reservationId); 
          },
           style: ElevatedButton.styleFrom(
    primary: paymentConfirmed ? Colors.green : Colors.red, // Couleur de fond du bouton
  ),
          child: Text('Confirmer '),
        ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}


class AddReservationDialog extends StatefulWidget {
    final String userType;

  const AddReservationDialog({super.key, required this.userType});

  @override
  _AddReservationDialogState createState() => _AddReservationDialogState();
}

class _AddReservationDialogState extends State<AddReservationDialog> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;


  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }
Future<void> saveReservation() async {
  try {
   
    // Collect data from the controllers and states
    String salonId = user!.uid;
    String userId =   user!.uid;
    String collectionname='';
    widget.userType=="freelancer"?  collectionname="freelancers" :widget.userType=="salons"? collectionname="salons":collectionname="";
     DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(collectionname)
        .doc(userId)
        .get();
     String salonName = userDoc['name']; // Replace with actual salon name
String formattedTime = '${_selectedTime.hour}-${_selectedTime.minute}';

    String userName = userNameController.text;
    String date = dateController.text;
    String time = timeController.text;
    String price = priceController.text;
    List<String> selectedServices = allSelectedSubservices.map((subservice) {
  return subservice['name'] as String;
}).toList();

  String reservationId = FirebaseFirestore.instance.collection('reservations').doc().id;


    // Build the reservation data
    Map<String, dynamic> reservationData = {
      'id':reservationId,
      'salonId': salonId,
      'salonName': salonName,
      'userId': userId,
      'userName': userName,
      'date': date,
      'time': time,
      'selectedServices':selectedServices ,
      'totalPrice': price
    };

    // Save the reservation data to Firestore
    await FirebaseFirestore.instance.collection('reservations').doc(reservationId).set(reservationData);
    showMessage("Réservation ajoutée avec succés");
    //**********User Reservation */
    Map<String, dynamic> UserReservationData = {
      'reservationId':reservationId,
      'payment':"Paid",
      'status': "Confirmed",
      'selectedServices':selectedServices ,
      'totalPrice': price
    };
     await FirebaseFirestore.instance.collection('userReservation').doc(reservationId) .set(UserReservationData);

    print('Reservation saved successfully');

  } catch (error) {
    print('Error saving reservation: $error');
  }
}
Future<List<Map<String, dynamic>>> fetchServicesWithSubservices(String userId) async {
  List<Map<String, dynamic>> servicesWithSubservices = [];
  String collectionName="";
  widget.userType=="freelancer"? collectionName="freelancers":collectionName="salons";
  QuerySnapshot serviceSnapshot = await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(userId)
      .collection('services')
      .get();

  for (QueryDocumentSnapshot serviceDoc in serviceSnapshot.docs) {
    String serviceName = serviceDoc['name'] as String;

    QuerySnapshot subserviceSnapshot = await serviceDoc.reference
        .collection('subservices')
        .get();

     List<Map<String, dynamic>> subservicesList = subserviceSnapshot.docs
        .map((subserviceDoc) {
          return {
            'name': subserviceDoc['name'] as String,
            'price': subserviceDoc['price'] ,
          };
        })
        .toList();

    servicesWithSubservices.add({
      'name': serviceName,
      'subservices': subservicesList,
    });
  }

  return servicesWithSubservices;
}
  List<Map<String, dynamic>> allSelectedSubservices = [];

Future<List<Map<String, dynamic>>> showServicesDialog(List<Map<String, dynamic>> servicesList) async {
  List<Map<String, dynamic>> selectedServices = [];

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Sélectionner des services souhaités'),
            content: SingleChildScrollView(
              child: Column(
                children: servicesList.map((service) {
                  String serviceName = service['name'] as String;
                  List<Map<String, dynamic>> subservices = service['subservices'] as List<Map<String, dynamic>>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: subservices.map((subservice) {
                          String subserviceName = subservice['name'] as String;
                          String subservicePrice = subservice['price'] as String;
                          bool isSelected = subservice['isSelected'] ?? false;

                          return CheckboxListTile(
                            title: Text('$subserviceName '),
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                subservice['isSelected'] = value;
                                if (value == true) {
                                  allSelectedSubservices.add(subservice);
                                } else {
                                  allSelectedSubservices.remove(subservice);
                                }
                              });
                            },
                            selected: isSelected,
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                }).toList(),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedServices);
                },
                child: Text('Valider'),
              ),
            ],
          );
        },
      );
    },
  );

  return selectedServices;
}


  TextEditingController userNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
    TextEditingController priceController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController selectedServicesController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: AlertDialog(
        title: Text('Ajouter réservation'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: userNameController,
                decoration: InputDecoration(labelText: 'Nom de l\'utilisateur'),
              ),
            TextField(
              controller: dateController,
              onTap: () async {
              DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
              );
            
              if (selectedDate != null) {
          setState(() {
            dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          });
              }
              },
              decoration: InputDecoration(labelText: 'Date'),
            ),
            
            TextField(
  controller: timeController,
onTap: () async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: _selectedTime,
  );

  if (pickedTime != null && pickedTime != _selectedTime) {
    setState(() {
      _selectedTime = pickedTime;
      // Formatez l'heure et les minutes en "hh-mm"
      final formattedTime = "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
      timeController.text = formattedTime;
    });
  }
},

  decoration: InputDecoration(labelText: 'Heure'),
),

              30.heightBox,
              InkWell(
              onTap: () async {
              print("Container tapped");
              String salonId = user!.uid;
              List<Map<String, dynamic>> servicesList = await fetchServicesWithSubservices(salonId);
               showServicesDialog(servicesList);
              },
              child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Services souhaités',
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.arrow_drop_down),
          ],
              ),
              ),
            ),
            
             TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Prix total'),
              ),
            20.heightBox,
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
             await saveReservation();
      Navigator.pop(context); // Close the dialog
            },
            child: Text('Confirmer',style: TextStyle(color: BbRed),),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Annuler',style: TextStyle(color: BbRed)),
          ),
        ],
      ),
    );
    
  }
}
