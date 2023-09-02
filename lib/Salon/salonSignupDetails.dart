import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_madamn_app/Salon/AddServices.dart';
import 'package:my_madamn_app/Salon/ReservationListe.dart';
import 'package:my_madamn_app/widgets_common/menu.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Consts/colors.dart';
import '../widgets_common/normal_text.dart';
import '../widgets_common/our_button.dart';
import 'package:path/path.dart' as path;

class SalonSignupDetails extends StatefulWidget {
 final String userType;

  const SalonSignupDetails({Key? key, required this.userType}) : super(key: key);
  @override
  State<SalonSignupDetails> createState() => _SalonSignupDetailsState();
}

class _SalonSignupDetailsState extends State<SalonSignupDetails> {
  List<String> selectedImagePaths = [];
List<File> imageFiles=[];
  String? currentUserDisplayName = FirebaseAuth.instance.currentUser?.displayName;
Position? _currentLocation ;
  late bool servicePermission=false;
  late LocationPermission permission;
  String _currentAddress="";
  TextEditingController addressController = TextEditingController();
    File? image;


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
  
  
  void _showFullScreenImage(String imagePath) {
 showDialog(
    context: context ,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width+10,
          height: MediaQuery.of(context).size.height,
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}

void takePicture() async {
  List<XFile>? images = await ImagePicker().pickMultiImage(imageQuality: 40);
  if (images != null && images.isNotEmpty) {
    setState(() {
      selectedImagePaths.addAll(images.map((image) => image.path));
    });
  }
}

  @override
  void initState() {
    super.initState();
   addressController.text = _currentAddress;
   //delay 2 seconds
  Future.delayed(Duration(seconds: 2), () {
    _showAddressDialog();
  });
  }
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
  appBar: AppBar(
        backgroundColor: BbRed,

    title: Text(""),
   
  ),
  drawer: Menu(context,widget.userType),
      body: SafeArea(
        child: Container(
          height: 800,
          width: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgimg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                        40.heightBox,
                          
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.heightBox,
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
                                controller: addressController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: _currentAddress,
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
                             20.heightBox,
                           // Text("Latitude = ${_currentLocation?.latitude}; longitude = ${_currentLocation?.longitude}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13)),
                                           
                                          
                            20.heightBox,
                            SizedBox(height: 20), // Added spacing between the text and photos section.
                            normalText(
                              text: "Veuillez sélectionner 5 photos au minimum",
                              color: BbRed,
                              size: 16.0,
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 410,
                              child:GridView.builder(
                                itemCount: selectedImagePaths.length + 1, // +1 for the Add button
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (context, index) {
                                  if (index < selectedImagePaths.length) {
                                    return GestureDetector(
                                      onTap: () {
                                // Handle image tap if needed
                                      _showFullScreenImage(selectedImagePaths[index]);
                              
                                      },
                                      child: Container(
                                margin: EdgeInsets.all(1),
                                  width: 100, // Ajustez la largeur selon vos besoins
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(File(selectedImagePaths[index])),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: takePicture,
                                      child: Container(
                                     width: 100, // Ajustez la largeur selon vos besoins
                                height: 100,
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ],
                                ),
                                      ),
                                    );
                                  }
                                },
                                ),
                            ),
                            20.heightBox,
                            Center(
                        child: SizedBox(
                          height: 45,
                          width: context.screenWidth - 107,
                          child: ourButton(
                            color: BbRed,
                            title: "Continuer",
                          onPress: () async {
                            print(widget.userType);
  addressController.text = _currentAddress;

  print(selectedImagePaths);
  print(addressController.text);

  try {
    List<String> imageUrls = [];

    for (String imagePath in selectedImagePaths) {
      if (imagePath != null) {
        var filename = path.basename(imagePath);
        var destination =
            '${widget.userType}/${FirebaseAuth.instance.currentUser?.displayName}/$filename';
        Reference ref =
            FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(File(imagePath));
        var imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    }

    if (widget.userType == "freelancer") {
      // Enregistrement dans la collection "freelancers"
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'address': addressController.text,
        'image': imageUrls,
      });
    } else {
      // Enregistrement dans la collection "salons"
      await FirebaseFirestore.instance
          .collection('salons')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'address': addressController.text,
        'image': imageUrls,
        // ... Autres champs de données spécifiques aux salons
      });
    }

    print('Data saved successfully!');

    // Naviguer vers l'écran suivant (par exemple, AddService)
Get.to(() => ReservationList(userType:widget.userType));
  } catch (e) {
    print('Error saving data: $e');
  }
},

                          ),
                        ),
                        ),
                        
                          ],
                        ).box
                            .width(300)
                            .height(880)
                            .color(Colors.white.withOpacity(0.5))
                            .rounded
                            .padding(const EdgeInsets.all(8))
                            .make(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
