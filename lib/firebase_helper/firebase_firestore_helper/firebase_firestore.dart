import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/constants.dart';
import '../../models/salon_model/salon_model.dart';
import '../../models/service_model/service_model.dart';
import '../../models/subservice_model/subservice.dart';
import '../../models/user_model/user_model.dart';

class FirebaseFirestoreHelper {
  
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //************Freelancers********************* */
  Future<List<SalonModel>> getFreelancers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("freelancers").get();

      List<SalonModel> salonsList = querySnapshot.docs
          .map((e) => SalonModel.fromJson(e.data()))
          .toList();

      return salonsList;
    } catch (e) {
      showMessage(e.toString());
      print(e);
      print("je suis dans getfreelancers");
      return [];
    }
  }
  //*************Salons****************
Future<List<SalonModel>> getSalons( String userType) async {
    try {
      String collectionName='';
      userType=="salons" ? collectionName='salons' : userType=="freelancer"? collectionName="freelancers": "Error";
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection(collectionName).get();

      List<SalonModel> salonsList = querySnapshot.docs
          .map((e) => SalonModel.fromJson(e.data()))
          .toList();

      return salonsList;
    } catch (e) {
      showMessage(e.toString());
      print(e);
      print("je suis dans getSalons");
      return [];
    }
  }
/////////////////////////////Services//////////////////
Future<List<ServiceModel>> getServices() async {
    try {
      print("Hi for 1 st time: ");
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore .collection("salons")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("services").get();
              print(FirebaseAuth.instance.currentUser);
          print(querySnapshot.docs);

      print("Hi for 2 nd time: ");
      List<ServiceModel> servicesModelList = querySnapshot.docs
          .map((e) => ServiceModel.fromJson(e.data()))
          .toList();
          
      print("Hi for 3 rd time: ");

      return  servicesModelList;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());
      print("je suis dans getServices");
      return [];
    }
  }////////////////////////////subservice////////////////
  Future<List<SubServiceModel>> getSubServices() async {
    try {
      print("Hi for 000 st time: ");
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
                .collection("salons")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("services")
                .doc() // Assuming you have the documentId in your ServiceModel
                .collection("subservices")
                .get();
              print(FirebaseAuth.instance.currentUser);
          print(querySnapshot.docs);

      print("Hi for 001 nd time: ");
      List<SubServiceModel> subservicesModelList = querySnapshot.docs
          .map((e) => SubServiceModel.fromJson(e.data()))
          .toList();
          
      print("Hi for 011 rd time: ");

      return  subservicesModelList;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());
      print("je suis dans getServices");
      return [];
    }
  }
Future<List<Map<String, dynamic>>> getServicesFromFirestore(String userType)async {
  try {
     String collectionName = "";
     userType == "freelancer"
        ? collectionName = "freelancers"
        :collectionName =  "salons";
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("services")
        .get();

    List<Map<String, dynamic>> servicesDataList = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data()!)
        .toList();

    return servicesDataList;
  } catch (e) {
    print("*********************Error fetching services: $e");
    return [];
  }
}

 /* Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      print("je suis dans getBestProduct");
      return [];
    }
  }*/
  

  Future<List<ServiceModel>> getSalonViewService(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("salons")
              .doc(id)
              .collection("services")
              .get();

      List<ServiceModel> serviceModelList = querySnapshot.docs
          .map((e) => ServiceModel.fromJson(e.data()))
          .toList();

      return serviceModelList;
    } catch (e) {
      showMessage(e.toString());
      print("je suis dans getSalonViewService");
      return [];
    }
  }




  //******************User Information */

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }
  
  //////// get salon info
  Future<SalonModel> getSalonInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("salons")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return SalonModel.fromJson(querySnapshot.data()!);
  } 

 

 Future<bool> uploadSalonReserveFirebase(
      List<Map<String, dynamic>> selectedServices, BuildContext context, String payment,String totalPrice,String reservationId) async {
    try {
      showLoaderDialog(context);
      DocumentReference documentReference = _firebaseFirestore
          .collection("usersReservations")
          .doc(reservationId)
          .collection("userreservations")
          .doc(reservationId);
      DocumentReference admin = _firebaseFirestore.collection("userReservation").doc(reservationId);
   print(reservationId);
      admin.set({
        "selectedServices":selectedServices,
        "status": "Pending",
        "totalePrice": totalPrice,
        "payment": payment,
        "reservationId": reservationId,
      });
      documentReference.set({
        "services": selectedServices,
        "status": "Pending",
        "totalePrice": totalPrice,
        "payment": payment,
        "reservationId": reservationId,
      });

      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Réservé avec succès");
      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

  

  ////// Get Order User//////

 

  void updateTokenFromFirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "notificationToken": token,
      });
    }
  }
}
