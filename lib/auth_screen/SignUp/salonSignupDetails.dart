import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/auth_screen/SignUp/SalonServices.dart';
import 'package:my_madamn_app/auth_screen/SignUp/chosescreen.dart';
import 'package:my_madamn_app/auth_screen/SignUp/signup_screen.dart';
//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';

class SalonSignupDetails extends StatefulWidget {
  const SalonSignupDetails({super.key});

  @override
  State<SalonSignupDetails> createState() => _SalonSignupDetailsState();
}

class _SalonSignupDetailsState extends State<SalonSignupDetails> {
  TextEditingController villeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> selectedPhotos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 500,
                    child: Image.asset(
                      "assets/madamen.png",
                      fit: BoxFit.contain,
                      height: 200,
                    ).box.width(200).height(250).make(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.heightBox,
                        Center(child: boldText(text: "Sign Up", color: BbRed)),
                        Row(
                          children: [
                            20.widthBox,
                            normalText(text: "Adresse", color: BbRed),
                          ],
                        ),
                        6.heightBox,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller: villeController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: BbRed),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: BbRed),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: 20), // Added spacing between the text and photos section.
                        normalText(
                          text: "Veuillez sélectionner 5 photos au minimum",
                          color: BbRed,
                          size: 10.0,
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 100,
                          child: GridView.builder(
                            itemCount: 3, // You can change this to the number of photos available.
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5, // Change this to adjust the number of photos per row.
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                                      final indexString = index.toString(); // Convert int to String

                                    // Toggle photo selection when tapped.
                                    if (selectedPhotos.contains(indexString)) {
                                      selectedPhotos.remove(indexString);
                                    } else {
                                      selectedPhotos.add(indexString );
                                    }
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedPhotos.contains(index)
                                          ? BbRed
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/photo_$index.jpg"), // Replace with actual photo URLs or paths.
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 80),
                        SizedBox(
                          height: 45,
                          width: context.screenWidth - 107,
                          child: ourButton(
                            color: BbRed,
                            title: "Continuer",
                            onPress: () async {
                              Get.to(() =>  SalonServices());
                            },
                          ),
                        ),
                      ],
                    ).box
                        .width(300)
                        .height(500)
                        .color(Colors.white.withOpacity(0.5))
                        .rounded
                        .padding(const EdgeInsets.all(8))
                        .make(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
