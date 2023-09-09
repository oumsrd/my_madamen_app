import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import '../models/salon_model/salon_model.dart';
import '../models/user_model/user_model.dart';


class AppProvider with ChangeNotifier {

 UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;


  SalonModel? _salonModel;


  SalonModel get getSalonInformation => _salonModel!;





////////////////////favorite salons/////
final List<SalonModel> _favouriteSalontList = [];

  void addFavouriteSalon(SalonModel salonModel) {
    _favouriteSalontList.add(salonModel);
    notifyListeners();
  }

  void removeFavouriteSalon(SalonModel salonModel) {
    _favouriteSalontList.remove(salonModel);
    notifyListeners();
  }

  List<SalonModel> get getFavouriteSalonList => _favouriteSalontList;

  


  ////// USer Information
  void getUserInfoFirebase() async {

    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();

    notifyListeners();
  }
/////// SAlon Information 
void getSalonInfoFirebase() async {
    _salonModel = await FirebaseFirestoreHelper.instance.getSalonInformation();
    notifyListeners();
  }
   void updateUserInfoFirebase( BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();

    } else {
      showLoaderDialog(context);

      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);

      _userModel = userModel.copyWith(image: imageUrl);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());

      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    showMessage("Profil mis à jour avec succès");

    notifyListeners();
  }
  /////////////////update salon information
Future<void> updateSalonInfoFirebase(
    BuildContext context, SalonModel salonModel,   File imageFile,
) async {
  try {
    print(00000000000000000000000000000);
    showLoaderDialog(context);
   // List<String> imageUrls = [];
 //for (File file in imageFiles) {
      String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(imageFile);
    //  imageUrls.add(imageUrl);
   // }
   salonModel = salonModel.copyWith(image: imageUrl);
    await FirebaseFirestore.instance
        .collection("salons")
        .doc(salonModel.id)
        .set(salonModel.toJson());
      print("DDDDDDDDDDDD");

    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context).pop();

    showMessage("Successfully updated salon information");

    notifyListeners();
  } catch (e) {
    print('Error updating salon information: $e');
    // Gérer l'erreur de manière appropriée, par exemple en affichant un message d'erreur.
  }
}

  

  

  

}
