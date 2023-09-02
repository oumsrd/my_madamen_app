import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/models/salon_model/salon_model.dart';
//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../widgets_common/normal_text.dart';
import '../SalonsScreen/SalonListScreen.dart';
import 'dart:async';

import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/menu_boutton.dart';
import '../widgets_common/our_button.dart';

class FreelancerDetails extends StatefulWidget {
  final stylist;

  const FreelancerDetails(this.stylist);

  @override
  State<FreelancerDetails> createState() => _FreelancerDetailsState();
}

class _FreelancerDetailsState extends State<FreelancerDetails> {
  List<String> comments = []; // Liste des commentaires
  TextEditingController commentController = TextEditingController();

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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    30.heightBox,
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5, // Number of images
                        itemBuilder: (context, index) {
                          // Return your image widget for each item
                          return Container(
                            width: MediaQuery.of(context).size.width / 3 - 5,
                            margin:
                                EdgeInsets.only(left: index == 0 ? 30 : 0, right: 20),
                            decoration: BoxDecoration(
                              color: widget.stylist['bgColor'],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  right: -28,
                                  child: Image.asset(
                                    widget.stylist['imgUrl'],
                                    scale: 1.7,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        color: whiteColor.withOpacity(0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Text(
                              widget.stylist['stylistName'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                           
                            SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.stylist['rating'],
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '(${widget.stylist['rateAmount']})',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                         /*  Text(
                          (widget.stylist['isForWomenOnly'] != null && widget.stylist['isForWomenOnly'])
                          ? "Cet espace est 100% femmes"
                          : "Cet espace n'est pas 100% femmes",
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          ),
                        ),*/

                            SizedBox(height: 10),
                           Center(
                          child: SizedBox(
                            height: 45,
                            width: context.screenWidth - 107,
                            child: ourButton(
                              color: BbRed,
                              title:"Poursuivre",
                              onPress: () {
                   /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SalonDetails(stylistData as SalonModel)));*/
                  },
                            ),
                          ),
                        ),
                            SizedBox(height: 10),
                            Text(
                                 'Adresse : ${widget.stylist['adresse']}',         
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            // Afficher les commentaires existants
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    'Oumeyma',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(comments[index],style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),
                                ));
                              },
                            ),
                            SizedBox(height: 10),
                            // Ajouter un commentaire
                            TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                labelText: 'Ajouter un commentaire',
                               labelStyle: TextStyle(
                               color:BbRed,
                             ),
                                
                              ),
                            ),
                            ourButton(
                              
                              title:'Soumettre',
                              color: BbRed,
                              onPress: () {
                                setState(() {
                                  comments.add(commentController.text);
                                  commentController.clear();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
