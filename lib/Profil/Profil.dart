import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_madamn_app/Consts/const.dart';
import 'package:my_madamn_app/auth_screen/Login/login_screen.dart';
import 'package:my_madamn_app/auth_screen/Login/sign_in_provider.dart';
import 'package:my_madamn_app/widgets_common/AppBar_widget.dart';
import 'package:my_madamn_app/widgets_common/next_screen.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:provider/provider.dart';
import '../widgets_common/menu_boutton.dart';

class Profil extends StatefulWidget {
  final String userName;
  final String userFirstName;
  final String userProfilePicUrl;
  final List<Map<String, dynamic>> reservations;

  Profil({
    required this.userName,
    required this.userFirstName,
    required this.userProfilePicUrl,
    required this.reservations,
  });

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
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
      final String? userEmail=user?.email;


    final sp=context.read<SignInProvider>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      drawer: MenuBoutton(context),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white, // Set the background color of the body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row( // Use Row to place the photo to the left of name and first name
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(widget.userProfilePicUrl),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email: $userEmail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$_firstName $_lastName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                 ourButton(
                                color: BbRed,
                                title: "Déconnecter",
                                onPress: () async{
                                sp.userSignOut();
                        nextScreenReplace(context, LoginScreen());
                                 
                                },
                              ),
                    

                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Ajoutez ici les informations personnelles de l'utilisateur selon votre structure de données
            // Exemple : Text('Adresse: ...'), Text('Téléphone: ...'), etc.

            SizedBox(height: 20),
            Text(
              'Historique des réservations:',
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
                  // ... reste du code inchangé
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
