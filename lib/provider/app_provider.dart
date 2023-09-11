import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    BuildContext context,   Map<String, dynamic> updatedData, File image
) async {
  try {
      List<dynamic> currentImages = updatedData["image"] ?? [];
      if (currentImages.isNotEmpty) {
    currentImages[0] = await FirebaseStorageHelper.instance.uploadUserImage(image!);
  }

    showLoaderDialog(context);   
    await FirebaseFirestore.instance
        .collection("salons")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(updatedData);

    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context).pop();

    showMessage("Informations ont mis à jour avec succès.");

    notifyListeners();
  } catch (e) {
    print('Error updating salon information: $e');

  }
}

  

  

  

}
