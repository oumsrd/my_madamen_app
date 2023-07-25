import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/Reservation/ReservationSuccess.dart';
import 'package:my_madamn_app/widgets_common/normal_text.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/menu_boutton.dart';



class ReservationSuccess extends StatefulWidget {
  @override
  State<ReservationSuccess> createState() => _ReservationSuccessState();
}

class _ReservationSuccessState extends State<ReservationSuccess> {

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    60.heightBox,
                    Center(child: boldText(text: "Votre réservation a bien ", color: BbRed, size: 24)),
                    Center(child: boldText(text: " été effectué !", color: BbRed, size: 24)),

                    300.heightBox,
                    Center(child: boldText(text: "Vous trouvez les détails de votre ", color: Colors.grey, size: 15)),
                    Center(child: boldText(text: " réservation dans mes réservations", color: Colors.grey, size: 15)),

                 
                  
                    
                 
                  ],
                ).box
                    .width(300)
                    .height(500)
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
