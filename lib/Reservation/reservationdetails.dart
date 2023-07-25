import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/Reservation/ReservationSuccess.dart';
import 'package:my_madamn_app/widgets_common/normal_text.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/menu_boutton.dart';



class ReservationDetails extends StatefulWidget {
  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> {
  String selectedHour = "12";
  String selectedMinute = "00";
  bool isHourTaken = false; // Variable pour vérifier si l'heure est prise

  // Contrôleur pour gérer l'heure sélectionnée
  TextEditingController hourController = TextEditingController();

  // Méthode pour vérifier si l'heure est prise
  bool checkIfHourTaken() {
    // Remplacez cette logique avec votre propre vérification de l'heure prise
    // Par exemple, vous pouvez comparer selectedHour avec l'heure prise dans une liste.
    // Si l'heure est prise, retournez true ; sinon, retournez false
    List<String> heuresPrises = ['10', '14', '16']; // Exemple de liste d'heures déjà réservées
    return heuresPrises.contains(selectedHour);
  }

  @override
  void initState() {
    super.initState();
    hourController.text = selectedHour; // Initialisez le contrôleur avec l'heure sélectionnée
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
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgimg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.heightBox,
                    Center(child: boldText(text: "Détails de la réservation", color: BbRed, size: 20)),
                    20.heightBox,
                    Center(child: normalText(text: "Sélectionnez l'heure", color: BbRed, size: 20)),
                  80.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: BbRed),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: selectedHour,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedHour = newValue!;
                                isHourTaken = checkIfHourTaken(); // Vérifie si l'heure est prise lorsqu'elle est modifiée
                              });
                            },
                            items: List<String>.generate(24, (index) => (index + 1).toString()).map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: BbRed,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ":",
                          style: TextStyle(
                            color: BbRed,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 80,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: BbRed),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: selectedMinute,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedMinute = newValue!;
                              });
                            },
                            items: List<String>.generate(60, (index) => index.toString().padLeft(2, '0')).map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: BbRed,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    if (isHourTaken) // Affiche le texte si l'heure est prise
                      const Text(
                        "Cette heure est déjà prise",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(height: 100),
                    170.heightBox,
                    Center(
                      child: SizedBox(
                        height: 45,
                        width: context.screenWidth - 107,
                        child: ourButton(
                          color: BbRed,
                          title: "Réserver",
                          onPress: () async {
                            // Service.login(loginController.emailController,loginController.passwordController);
                            Get.to(() => ReservationSuccess());
                          },
                        ),
                      ),
                    ),
                  ],
                ).box
                    .width(300)
                    .height(600)
                    .color(Colors.white.withOpacity(0.5))
                    .rounded
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
