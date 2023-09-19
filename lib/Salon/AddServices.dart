import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_rim/models/subservice_model/subservice.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Consts/colors.dart';
import '../constants/constants.dart';
import '../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../models/service_model/service_model.dart';
import '../widgets_common/menu.dart';
import '../widgets_common/our_button.dart';
import '../auth_screen/SignUp/ServiceDetails.dart';
import 'SubServiceDialog.dart';
import 'package:path/path.dart' as path;
class AddService extends StatefulWidget {


  final String userType;

  const AddService({Key? key, required this.userType}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  List<SubServiceModel> subServices = [];
  List<SubServiceModel> addedSubServices = [];


List<ServiceModel> serviceModelList = [];
  bool isLoading = false;
  @override
   void initState() {
   // AppProvider appProvider = Provider.of<AppProvider>(context , listen: false);
   // appProvider.getSalonInfoFirebase();
     getServiceList();
    super.initState();
  }

  void getServiceList() async {
    setState(() {
      isLoading = true;
    });
    serviceModelList = await FirebaseFirestoreHelper.instance.getServices();

    serviceModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
  XFile? selectedImage;
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController nombre_personnelsController = TextEditingController();
    TextEditingController serviceImageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un service"),
        backgroundColor: BbRed,
      ),
      drawer: Menu(context,widget.userType),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: serviceNameController,
              decoration:const  InputDecoration(
                labelText: "Nom du service",labelStyle: TextStyle(color: BbRed),
                 focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: BbRed), 
  ),
                focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: BbRed), 
  ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nombre_personnelsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nombre de personnels ",labelStyle: TextStyle(color: BbRed),
                focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: BbRed), 
  ),
                focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: BbRed), 
  ),
              ),
            ),
            SizedBox(height: 20),
            
            TextFormField(
  controller: serviceImageController,
  decoration: InputDecoration(
    labelText: "Image",labelStyle: TextStyle(color: BbRed),
    focusedBorder: const OutlineInputBorder(
                 borderSide: BorderSide(color: BbRed), 
  ),
                focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: BbRed), 
  ),
    suffixIcon: IconButton(
      icon: const Icon(Icons.add_photo_alternate),
      onPressed: () async {
        // Utiliser ImagePicker pour sélectionner une image depuis la galerie
        XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          setState(() {
            selectedImage = pickedImage;
            // Vous pouvez également enregistrer le chemin de l'image dans votre controller ici si nécessaire
            serviceImageController.text = pickedImage.path;

          });
          
        }
      },
    ),
  ),
),            SizedBox(height: 20),

  TextFormField(
 // controller: nombre_personnelsController,
  decoration: InputDecoration(
    labelText: "Sous service",labelStyle: TextStyle(color: BbRed),
    suffixIcon: IconButton(
      icon: Icon(Icons.add),
      onPressed: () async {
        try{
              SubServiceModel? newSubService = await showDialog<SubServiceModel>(
      context: context,
      builder: (BuildContext context) {
        return AddSubServiceDialog();
      },
    );
    if (newSubService != null) {
      setState(() {
        addedSubServices.add(newSubService);
       
      });
    }}catch (e) {
      
      print("the error is : $e "   );}
      },
    ),
  ),
),
12.heightBox,

            Center(
              child: SizedBox(
                 height: 45,
                width: context.screenWidth - 107,
                child: ourButton(
                title: "Ajouter",
                onPress: () async {
              
                  try {
                    var filename = path.basename(selectedImage!.path);
                  var destination =
                     'services/${FirebaseAuth.instance.currentUser?.displayName}/$filename';
                Reference ref =
                    FirebaseStorage.instance.ref().child(destination);
                  await ref.putFile(File(selectedImage!.path));
                  String nImageRef = await ref.getDownloadURL();
                       serviceImageController.text=nImageRef;
                       String collectionName = "";
                       widget.userType == "freelancer"
                      ?  collectionName = "freelancers"
                      : widget.userType == "salons" ? collectionName =  "salons": collectionName = "";
                    DocumentReference serviceDocumentReference = FirebaseFirestore.instance
                        .collection(collectionName)
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("services")
                        .doc();
              
                    await serviceDocumentReference.set({
                      'nombre_personnels': nombre_personnelsController.text,
                      'name': serviceNameController.text,
                      'image': serviceImageController.text,
                    });
              
                    for (SubServiceModel item in addedSubServices) {
                      await serviceDocumentReference.collection("subservices").add({
                        'nombre_personnels': item.nombre_personnels,
                        'name': item.name,
                        'image': item.image,
                        'price': item.price,
                      });
                    }
                       ServiceModel newService = ServiceModel(
                        name: serviceNameController.text,
                        nombre_personnels: nombre_personnelsController.text,
                        image: serviceImageController.text,
                      );
              
                      setState(() {
                        serviceModelList.add(newService);
                          serviceNameController.clear();
                    nombre_personnelsController.clear();
                    serviceImageController.clear();
                    addedSubServices.clear(); // Add the new service to the list
                      });
              
                     showMessage("Votre service a été ajouté avec succès");
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              ),
          ),
            SizedBox(height: 20),
            Expanded(
  child: FutureBuilder<List<Map<String, dynamic>>>(
    future: FirebaseFirestoreHelper.instance.getServicesFromFirestore(widget.userType),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Afficher un indicateur de chargement pendant le chargement des données
      } else if (snapshot.hasError) {
        return Text("Erreur : ${snapshot.error}");
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Text("Aucun service disponible.");
      } else {
        return ListView.builder(
  itemCount: serviceModelList.length,
  itemBuilder: (context, index) {
    ServiceModel singleService = serviceModelList[index];
    print(singleService.name);
  
    print(singleService);

    return GestureDetector(
      onTap: () {
        // Navigate to the service details page here
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailsPage(service: singleService),
          ),
        );
      },
      child: ListTile(
        title: Text(singleService.name),
        subtitle: Text("Nombre de personnel: ${singleService.nombre_personnels}"),

      ),
    );
  },
);

      }
    },
  ),
),
           
          ],
        ),
      ),
    );
  }
}
