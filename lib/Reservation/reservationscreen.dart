/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/Reservation/reservationdetails.dart';
import 'package:my_madamn_app/widgets_common/normal_text.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../SalonsScreen/Salon.dart';
import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/menu_boutton.dart';



class ReservationScreen extends StatefulWidget {
  final Salon salon;

  ReservationScreen({required this.salon});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      drawer: MenuBoutton(context),
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
                    boldText(text: "Promotion du jour", color: BbRed, size: 20),
                    Center(child: normalText(text: widget.salon.name, color: BbRed, size: 20)),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            widget.salon.imageURL,
                            fit: BoxFit.fitWidth,
                            height: 150,
                            width: 150,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make(),
                        ],
                      ),
                    ),
                    // Reservation details
                    SizedBox(height: 50),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Promotion: ",
                            style: TextStyle(
                              color: BbRed,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 100,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: BbRed),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "-50%",
                                  style: TextStyle(
                                    color: BbRed,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Prix:            ",
                            style: TextStyle(
                              color: BbRed,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 100,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: BbRed),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "169 DH",
                                  style: TextStyle(
                                    color: BbRed,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100),
                    30.heightBox,
                    Center(
                      child: SizedBox(
                        height: 45,
                        width: context.screenWidth - 107,
                        child: ourButton(
                          color: BbRed,
                          title: "Réserver",
                          onPress: () async {
                            // Service.login(loginController.emailController,loginController.passwordController);
                            Get.to(() => ReservationDetails());
                          },
                        ),
                      ),
                    ),
                  ],
                ).box
                    .width(300)
                    .height(600)
                    .color(Colors.white.withOpacity(0.5),)
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
*/


