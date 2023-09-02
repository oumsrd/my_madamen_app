import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_madamn_app/widgets_common/AppBar_widget.dart';

class HistoriqueReservation extends StatefulWidget {
  @override
  State<HistoriqueReservation> createState() => _HistoriqueReservationState();
}

class _HistoriqueReservationState extends State<HistoriqueReservation> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _firstName = "";

  List<Map<String, dynamic>> _reservations = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadUserReservations();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = _auth.currentUser;
      String userId = user!.uid;
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(userId).get();

      setState(() {
        _firstName = docSnapshot['name'];
        //_lastName = docSnapshot['lastName'];
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

      setState(() {
        _reservations = reservationSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print('Error fetching user reservations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundImage: 
           NetworkImage(user!.photoURL!)
         
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
           const  SizedBox(height: 20),
            const Text(
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
                  final date = reservation['date'] ;
                  final time = reservation['time'] ;
                  final salon = reservation['salonName'];
                  final price = reservation['totalPrice'];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Salon: $salon',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Date: $date',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Heure: $time',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                             SizedBox(height: 10),
                          Text(
                            'Prix total: $price DH',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),

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
