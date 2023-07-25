import 'package:flutter/material.dart';
import 'package:my_madamn_app/widgets_common/AppBar_widget.dart';
import '../widgets_common/menu_boutton.dart';

class Profil extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                  backgroundImage: AssetImage(userProfilePicUrl),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nom: $userName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Prénom: $userFirstName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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
                itemCount: reservations.length,
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
