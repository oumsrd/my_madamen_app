import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_madamn_app/widgets_common/AppBar_widget.dart';
import 'dart:async';

class HistoriqueReservation extends StatefulWidget {
const HistoriqueReservation({Key? key, }) : super(key: key); 
 static const route="/HistoriqueReservation";
  @override
  State<HistoriqueReservation> createState() => _HistoriqueReservationState();
}

class _HistoriqueReservationState extends State<HistoriqueReservation> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _firstName = "";

  List<Map<String, dynamic>> _reservations = [];
  late Map<String, bool> _serviceUtilizedMap = {};

  StreamController<Map<String, String>> _statusController =
      StreamController<Map<String, String>>();

  @override
  void initState() {
    _loadUserData();
    _loadUserReservations();


    super.initState();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = _auth.currentUser;
      String userId = user!.uid;
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(userId).get();

      setState(() {
        _firstName = docSnapshot['name'];
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _loadUserReservations() async {
    try {
      User? user = _auth.currentUser;
      String userId = user!.uid;
      QuerySnapshot reservationSnapshot = await _firestore
          .collection('reservations')
          .where('userId', isEqualTo: userId)
          .get();
           for (QueryDocumentSnapshot doc in reservationSnapshot.docs) {
      final reservationId = doc.id;
      final statusDoc = await _firestore
          .collection('userReservation')
          .doc(reservationId)
          .get();

      final status = statusDoc['status'] as String;

      // Initialisez _serviceUtilizedMap ici en fonction du statut
      setState(() {
        _reservations.add(doc.data() as Map<String, dynamic>);
        _serviceUtilizedMap[reservationId] = status == 'Confirmed';
      });
    }
      // Triez la liste des réservations en ordre décroissant de la date et de l'heure
      _reservations.sort((a, b) {
        DateTime dateA = DateTime.parse(a['date'] + ' ' + a['time']);
        DateTime dateB = DateTime.parse(b['date'] + ' ' + b['time']);
        return dateA.compareTo(dateB);
      });
    } catch (e) {
      print('Error fetching user reservations: $e');
    }
  }
  //********update status de reservation */
  Future<void> _updateReservationStatus(String reservationId, String newStatus) async {
  try {
    await _firestore.collection('userReservation').doc(reservationId).update({
      'status': newStatus,
    });

    // Mettez à jour l'état de l'interface utilisateur pour refléter le changement
    setState(() {
      _serviceUtilizedMap[reservationId] = true; // Assurez-vous que c'est vrai lorsque le statut est "Confirmé"
    });
  } catch (e) {
    print('Error updating reservation status: $e');
  }
}
  // ... Vos autres méthodes comme _updateReservationStatus() ici ...

  @override
  Widget build(BuildContext context) {
    final message=ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
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
                  backgroundImage: NetworkImage(user!.photoURL!),
                ),
                SizedBox(width: 10),
                Text(
                  ' $_firstName',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Réservations:',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child:
              // StreamBuilder<Map<String, String>>(
              //  stream: _statusController.stream,
               // builder: (context, snapshot) {
               //   if (snapshot.connectionState == ConnectionState.active) {
                  //  return
                     ListView.builder(
                      itemCount: _reservations.length,
                      itemBuilder: (context, index) {
                           final reservation = _reservations[index];

                  final selectedServices =
                      reservation['selectedServices'] ;
                  final date = reservation['date'] ;
                  final time = reservation['time'] ;
                  final salon = reservation['salonName'];
                  final price = reservation['totalePrice'];

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
                            style:const  TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                          Text(
                            'Heure: $time',
                            style: const TextStyle(
                              fontSize: 16,
                           fontWeight: FontWeight.bold,

                            ),
                          
                          ),
                          const Text(
                            '=================',
                            style: TextStyle(
                              fontSize: 16,
                           fontWeight: FontWeight.bold,

                            ),),
                             SizedBox(height: 10),
                          Text(
                            'Salon: $salon',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 10),
                         
                          Text(
                            'Prix total: $price DH',
                            style:const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 5),

                       //   SizedBox(height: 10),
                          Text(
                            'Services:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        
                         Column(
  children: selectedServices
      .map<Widget>(
        (service) => ListTile(
          title: Text(
            service,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
         /* subtitle: Text(
            ' ${service['price']} DH',
            style: TextStyle(
              fontSize: 12,
            ),
          ),*/
        ),
      )
      .toList(),
),
    Text(
      'Avez-vous bénéficié du service ?',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    Row(
  children: [
    ElevatedButton(
      onPressed: () async {
        String reservationId = reservation['id'];
        DocumentSnapshot doc= await _firestore.collection('userReservation').doc(reservationId).get();
       
        if (doc['status'] == 'Confirmed') {
          // La réservation est confirmée, donc le bouton "Oui" sera vert
          setState(() {
            _serviceUtilizedMap[reservation['id']] = true;
          });
        } else {
          // La réservation n'est pas confirmée, donc mettez à jour le statut ici
          _updateReservationStatus(reservationId, "Confirmed");
        }
      },
      style: ElevatedButton.styleFrom(
        primary: _serviceUtilizedMap[reservation['id']] == true
            ? Colors.green // Couleur "Oui" sélectionnée
            : Colors.grey,
      ),
      child: Text('Oui'),
    ),

    SizedBox(width: 10),

    ElevatedButton(
      onPressed: () {
        setState(() {
          _serviceUtilizedMap[reservation['id']] = false;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: _serviceUtilizedMap[reservation['id']] == false
            ? Colors.red // Couleur "Non" sélectionnée
            : Colors.grey,
      ),
      child: Text('Non'),
    ),

    SizedBox(width: 120,),

    Text(
      _serviceUtilizedMap[reservation['id']] == true
          ? "Confirmé"
          : "En cours",
      style: TextStyle(
        color: _serviceUtilizedMap[reservation['id']] == true
            ? Colors.green
            : Colors.red,
      ),
    )
  ],
),])));
                        // Votre code de carte de réservation ici...
                      },
                    )
                 // } else {
                 //   return CircularProgressIndicator();
                  //}
              //  },
            //  ),
            ),
          ],
        ),
      ),
    );
  }
}
