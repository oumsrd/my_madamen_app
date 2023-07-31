import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_madamn_app/widgets_common/AppBar_widget.dart';

import '../widgets_common/menu_boutton.dart';

class HistoriqueReservation extends StatefulWidget {
  final String userName;
  final List<Map<String, dynamic>> reservations;

  HistoriqueReservation({required this.userName, required this.reservations});

  @override
  State<HistoriqueReservation> createState() => _HistoriqueReservationState();
}

class _HistoriqueReservationState extends State<HistoriqueReservation> {
  User? user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _firstName;
  late String _lastName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = _auth.currentUser;
      String userId = user!.uid;
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(userId).get();

      setState(() {
        _firstName = docSnapshot['firstName'];
        _lastName = docSnapshot['lastName'];
      });
    } catch (e) {
      // Gérez les erreurs ici.
      print('Erreur lors de la récupération des données : $e');
    }
  }

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
        padding: EdgeInsets.all(20.0),
        color: Colors.white, // Set the background color of the body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Utilisateur: $_firstName $_lastName',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Réservations:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.reservations.length,
                itemBuilder: (context, index) {
                  final reservation = widget.reservations[index];
                  final selectedServices =
                      reservation['selectedServices'] as List<Map<String, dynamic>>;
                  final date = reservation['date'] as DateTime;
                  final time = reservation['time'] as TimeOfDay;
                  final salon = reservation['stylistName'].toString();

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.grey[200], // Set the card background color
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Salon: SalonName',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Date: ${date.toString().split(' ')[0]}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Heure: ${time.format(context)}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Services:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Column(
                            children: selectedServices
                                .map(
                                  (service) => ListTile(
                                    title: Text(
                                      service['title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${service['duration']} Minutes - ${service['price']} DH',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
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
