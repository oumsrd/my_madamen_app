import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_rim/models/subservice_model/subservice.dart';

import '../Consts/colors.dart';

import 'package:path/path.dart';

class AddSubServiceDialog extends StatefulWidget {
  @override
  _AddSubServiceDialogState createState() => _AddSubServiceDialogState();
}

class _AddSubServiceDialogState extends State<AddSubServiceDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sousServicenbrePersonnelsController = TextEditingController();
  TextEditingController sousServiceImageController = TextEditingController();
  @override  
  XFile? selectedImage;
  

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Ajouter un sous-service"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Nom du sous-service",labelStyle: TextStyle(color: BbRed),
            focusedBorder:  OutlineInputBorder(
                 borderSide: BorderSide(color: BbRed), 
  ),
                focusedErrorBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: BbRed), 
  ),),
            
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Prix",labelStyle: TextStyle(color: BbRed),
            focusedBorder:  OutlineInputBorder(
                 borderSide: BorderSide(color: BbRed), 
  ),
                focusedErrorBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: BbRed), 
  ),),
            
          ),
         TextField(
  controller: sousServicenbrePersonnelsController,
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    labelText: "Nombre de personnels",
    labelStyle: TextStyle(color: BbRed), // Changez ici la couleur du texte du label
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: BbRed),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: BbRed),
    ),
  ),
),

            TextField(
  controller: sousServiceImageController,
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
            sousServiceImageController.text = pickedImage.path;

          });
          
        }
      },
    ),
  ),
),  
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
           style: ElevatedButton.styleFrom(
    primary: BbRed, // Changez ici la couleur du bouton à BbRed
  ),
          child: Text("Annuler"),
        ),
       // Dans la classe AddSubServiceDialog
ElevatedButton(
  onPressed: () async {
    print(nameController.text);
   try{ 
    var filename = basename(selectedImage!.path);
                var destination =
                    'services/${FirebaseAuth.instance.currentUser?.displayName}/$filename';
                Reference ref =
                    FirebaseStorage.instance.ref().child(destination);
                await ref.putFile(File(selectedImage!.path));
                String nImageRef = await ref.getDownloadURL();

               sousServiceImageController.text=nImageRef;
    SubServiceModel newSubService = SubServiceModel(
      //id: '',
      name: nameController.text,
      price: priceController.text,
      image: sousServiceImageController.text,
      nombre_personnels: sousServicenbrePersonnelsController.text,
      
    );
                 // subServicesList.add(newSubService);
             
    Navigator.of(context).pop(newSubService);}
    catch(e){print("this is errooooor $e");}
  },
  style: ElevatedButton.styleFrom(
    primary: BbRed, // Changez ici la couleur du bouton à BbRed
  ),
  child: Text("Ajouter"),
),

      ],
    );
  }
}
