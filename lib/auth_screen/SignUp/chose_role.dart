import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:my_madamn_app/auth_screen/SignUp/chosescreen.dart';
import 'package:my_madamn_app/auth_screen/SignUp/signup_screen.dart';
//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';
class ChoseRole extends StatefulWidget {
  
  const ChoseRole({super.key});

  @override
  State<ChoseRole> createState() => _ChoseRoleState();
}

class _ChoseRoleState extends State<ChoseRole> {
Position? _currentLocation ;
    late bool servicePermission=false;
    late LocationPermission permission;
    String _currentAddress="";

    Future<Position> _getCurrentLocation()async{
      servicePermission=await Geolocator.isLocationServiceEnabled();
      if(!servicePermission){
         print("service disabled");
      }  permission=await Geolocator.checkPermission();
        if(permission==LocationPermission.denied){
          permission=await Geolocator.requestPermission() ;
        }

      return await Geolocator.getCurrentPosition();
    }
    _getAdresseFromCoordinates()async{
     try {
  List<Placemark> placemarks = await placemarkFromCoordinates(
    _currentLocation!.latitude, 
    _currentLocation!.longitude
  );
  if (placemarks.isNotEmpty) {
    Placemark place = placemarks[0];
    setState(() {
      _currentAddress = "${place.locality}, ${place.country}";
    });
  } else {
    print("No placemarks found.");
  }
} catch (e) {
  print("Error fetching address: $e");
}


    }

  TextEditingController villeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  void _showAddressDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Localisation Actuelle"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Voulez vous utiliser votre adresse actuelle?"),
            SizedBox(height: 20),
            SizedBox(
              height: 45,
              width: context.screenWidth - 200,
              child: ourButton(
                color: BbRed,
                title: "Confirmer",
                onPress: () async {
                  _currentLocation = await _getCurrentLocation();
                  await _getAdresseFromCoordinates();
                  print("Current Address: $_currentAddress");
                  print("Current Location: $_currentLocation");
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
   @override
  void initState() {
    super.initState();
   villeController.text = _currentAddress;
   //delay 2 seconds
  Future.delayed(Duration(seconds: 2), () {
    _showAddressDialog();
  });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        height: double.infinity ,
        width: 500,
       
        decoration:const BoxDecoration(
         image: DecorationImage(
          image: AssetImage("assets/bgimg.jpg"),
          fit: BoxFit.cover,
        ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              
              children: [
                80.heightBox,

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : [
                      20.heightBox,
                                        Center(child: boldText(text: "Sign Up",color: BbRed)),

                      Row(children:[ 
                        20.widthBox,
                        normalText(text:"Ville",color: BbRed)]),
                      6.heightBox,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: TextFormField(
                          controller: villeController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: _currentAddress, // Use _currentAddress as the hintText
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:  BbRed),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:  BbRed), // Couleur du contour lorsqu'en focus
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          ),
                        ),
                        
                      ),
                     20.heightBox,
                  // Text("Latitude = ${_currentLocation?.latitude}; longitude = ${_currentLocation?.longitude}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13)),
                       
                      
                      20.heightBox,
                     /* Center(
                          child: SizedBox(
                            height: 45,
                            width: context.screenWidth - 200,
                            child: ourButton(
                              color: BbRed,
                              title: "Localisation actuelle",
                              onPress: () async{
                              Get.to(() =>  ChoseRole());
                           _currentLocation=await _getCurrentLocation();
                            await _getAdresseFromCoordinates();
                            print("${_currentAddress}");
                            print("${_currentLocation}");
                               
                              },
                            ),
                          ),
                        ),*/
                      SizedBox(height: 80),
                      Center(child: boldText(text: "Vous Etes ?",color: BbPink)),
                      SizedBox(height: 40,),
                    Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    SizedBox(
      height: 110,
      width: 110,
      child: ourButton(
      color: BbRed.withOpacity(0.5),
      title: "Fournisseur de services",
      onPress: () async {
        // Service.login(loginController.emailController,loginController.passwordController);
        Get.to(() => const ChoseScreen());
      },
      ),
    ),
    SizedBox(
      height: 110,
      width: 110,
      child: ourButton(
      color: BbRed.withOpacity(0.5),
      title: "Cliente",
      onPress: () async {
         Get.to(() =>  SignupScreen(userType: "",));
      },
      ),
    ),
  ],
),

                    ]
                  ).box
                  .width(300)
                  .height(550)
                  .color(Colors.white.withOpacity(0.5))
                  .rounded
                  .padding(const EdgeInsets.all(8))
                  .make(),
                ),
              
              ],
            )
          ),
        ),
      ),
    );
  }
}