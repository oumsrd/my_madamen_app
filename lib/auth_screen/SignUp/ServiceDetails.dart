import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:provider/provider.dart';

import '../../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../../models/service_model/service_model.dart';
import '../../models/subservice_model/subservice.dart';
import '../../provider/app_provider.dart';


class ServiceDetailsPage extends StatefulWidget {
  final ServiceModel service;

  ServiceDetailsPage({required this.service});

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  List<SubServiceModel> subserviceModelList = [];
  bool isLoading = false;
  @override
   void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getSalonInfoFirebase();
     getSubServiceList();
    super.initState();
  }

  void getSubServiceList() async {
    setState(() {
      isLoading = true;
    });
    subserviceModelList = await FirebaseFirestoreHelper.instance.getSubServices();

    subserviceModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails du service"),
      ),
      body: Column(
        children: [
          Text("Nom du service: ${widget.service.name}"),
          Text("Nombre de personnel: ${widget.service.nombre_personnels}"),
          // Other service details

          // Fetch and display sub-services
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("salons")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("services")
                .doc(widget.service.name) // Assuming you have the documentId in your ServiceModel
                .collection("subservices")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text("No sub-services available.");
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: subserviceModelList.length,
                  itemBuilder: (context, index) {
                  SubServiceModel  subService = subserviceModelList[index];
                    return ListTile(
                      title: Text(subService.name),
                      subtitle: Text("Price: ${subService.price}"),
                      // Other sub-service details
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

