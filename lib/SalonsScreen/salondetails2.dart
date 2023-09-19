import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Consts/colors.dart';
import '../constants/constants.dart';
import '../models/salon_model/salon_model.dart';
import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/our_button.dart';
import 'ReserverSalon.dart';
class SalonDetails2 extends StatefulWidget {
 final String userType;
  final SalonModel salonModel;
  SalonDetails2(this.salonModel, this.userType);
  @override
  State<SalonDetails2> createState() => _SalonDetails2State();
}

class _SalonDetails2State extends State<SalonDetails2> {
    List<Map<String, dynamic>> selectedServices = [];

  bool isSelected = true;
  Future<String> goToReserverSalon() async {
  final reservationRef = FirebaseFirestore.instance.collection('reservations').doc();
  return reservationRef.id; 
}


void toggleSubService(Map<String, dynamic> subServiceData) {
  print(subServiceData);
  print(selectedServices);
  setState(() {
    if (isSelected) {
      selectedServices.add(subServiceData);
          //  isSelected = !isSelected; 
        updateTotalPrice();

    } else {
      selectedServices.add(subServiceData);
      //isSelected = !isSelected;
          updateTotalPrice();

          ();

    }
    print(selectedServices);
    print(totalPrice);
  });
    
  
}
  num totalPrice = 0;

  void updateTotalPrice() {
  num newTotalPrice = 0;
  for (var service in selectedServices) {
    // Convert 'price' to num before adding
    newTotalPrice += num.parse(service['price']);
  }
  setState(() {
    totalPrice = newTotalPrice;
  });
}
List<Map<String, dynamic>> Services=[];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
              ),
            ),
            child: Padding(
              
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 30,),
                    ServiceList(
                      widget.salonModel,
                     toggleSubService,
                     Services,
                     isSelected,
                     widget.userType
                     ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Prix total:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${totalPrice} DH',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                     Center(
                    child: Text(
                      'Services sélectionnés:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedServices.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> selectedSubService = selectedServices[index];
                      return ListTile(
                        title: Text(selectedSubService['name']),
                        subtitle: Text('${selectedSubService['price']} DH'),
                      );
                    },
                  ),
                    Center(
                      child: SizedBox(
                        height: 45,
                        width: context.screenWidth - 107,
                        child: ourButton(
                          color: BbRed,
                          title: "Poursuivre",
                          onPress: () async {
                            print(widget.salonModel.name);
                            QuerySnapshot<Map<String, dynamic>> doc =await FirebaseFirestore.instance.collectionGroup('services').get();
                            print(doc);
                            List<String> serviceNames = [];
              
                    // Parcourir les documents pour extraire les noms de service
                    doc.docs.forEach((serviceDoc) {
                      String serviceName = serviceDoc.get('name'); 
                      serviceNames.add(serviceName);
                    });
                    print(serviceNames);
                           String reservationId = await goToReserverSalon();
                           print(reservationId);
              
                   Get.to(() => ReserverSalon(
                    userType: widget.userType,
                    reservationId: reservationId,
                   salonModel: widget.salonModel,
                    selectedServices: selectedServices,
                    totalPrice: totalPrice,
                  ));
                  
                            print(isSelected);
                            print(selectedServices);
                       
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceList extends StatelessWidget {
  final SalonModel salon;
  final Function(Map<String, dynamic>) onSubServiceToggle;
  final List<Map<String, dynamic>> selectedServices;
  final bool isSelected;
  final String userType;


  ServiceList(this.salon, this.onSubServiceToggle, this.selectedServices, this.isSelected, this.userType);

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
       .collection(userType=="freelancer" ? "freelancers": userType=="salons" ? "salons": "")
         .doc(salon.id)
          .collection('services')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Waiting for data
        }

        List<DocumentSnapshot> serviceDocs = snapshot.data!.docs;

        return Column(
          children: serviceDocs.map<Widget>((serviceDoc) {
            String serviceName = serviceDoc.get('name');

            return Column(
              children: [
                Text(
                  serviceName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: BbRed,
                  ),
                ),
                SubSubServiceList(
                  serviceDoc.reference,
                  onSubServiceToggle,
                  selectedServices,
                  isSelected,


                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

class SubSubServiceList extends StatelessWidget {
  final DocumentReference subserviceRef;
  final Function(Map<String, dynamic>) onSubServiceToggle;
  final List<Map<String, dynamic>> selectedServices;
    final bool isSubServiceSelected;



  SubSubServiceList(
    this.subserviceRef, 
    this.onSubServiceToggle, 
    this.selectedServices, 
    this.isSubServiceSelected,
    );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: subserviceRef.collection('subservices').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Waiting for data
        }

        List<DocumentSnapshot> subserviceDocs = snapshot.data!.docs;

        return Column(
          children: subserviceDocs.map<Widget>((subserviceDoc) {
            Map<String, dynamic> subServiceData = {
              'name': subserviceDoc.get('name'),
              'price': subserviceDoc.get('price'),
            };

          //  bool isSubServiceSelected = selectedServices.contains(subServiceData);
          
            print(subserviceDoc);
           return Container(
              color: 
              //isSubServiceSelected
                //  ? Colors.red.withOpacity(0.5)
                  Colors.white.withOpacity(0.5),
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        child: Text(
                          subServiceData['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: /*isSubServiceSelected
                                ? Colors.red
                                :*/Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${subServiceData['price']} DH',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                       color:/* isSubServiceSelected
                                ? Colors.red
                                :*/Colors.black,
                    ),
                  ),
                  MaterialButton(
                    onPressed:(){
                     // for(var subserv in subServiceData)
                     print("*******");
                     print(selectedServices);
                     print("*******");
                     showMessage("Service a bien été ajouté");
                     print(subServiceData);
                      onSubServiceToggle(subServiceData);
                      },
                    color: /*isSubServiceSelected ? Colors.red :*/ BbPink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                     /* isSubServiceSelected ? 'Annuler' :*/ 'Choisir',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}