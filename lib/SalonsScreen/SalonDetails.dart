import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Reservation/ReservationSuccess.dart';
import '../bienvenue/bienvenue.dart';
import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/menu_boutton.dart';
import '../widgets_common/our_button.dart';
import 'ReserverSalon.dart';

var servicechevelure = [
  {'title': 'Bruching', 'duration': 45, 'price': 100},
  {'title': 'Coloration', 'duration': 60, 'price': 250},
  {'title': 'Coupe', 'duration': 90, 'price': 50},
  {'title': 'Soin keratine', 'duration': 30, 'price': 300},
];
var serviceonglerie = [
  {'title': 'Manicure', 'duration': 45, 'price': 100},
  {'title': 'Pédicure', 'duration': 60, 'price': 100},
  {'title': 'Pose vernis simple', 'duration': 90, 'price': 50},
  {'title': 'Soin ongles', 'duration': 30, 'price': 100},
];
var servicecorporel = [
  {'title': 'Cire aisselles', 'duration': 45, 'price': 100},
  {'title': 'Jambes', 'duration': 60, 'price': 250},
  {'title': 'Cire maillot', 'duration': 90, 'price': 50},
  {'title': 'Massage', 'duration': 30, 'price': 300},
];
var servicefacial = [
  {'title': 'Hydrofacial', 'duration': 90, 'price': 50},
  {'title': 'Microneedling', 'duration': 30, 'price': 300},
    {'title': 'Microneedling', 'duration': 30, 'price': 300},

];

class SalonDetails extends StatefulWidget {
  final stylist;

  SalonDetails(this.stylist);

  @override
  _SalonDetailsState createState() => _SalonDetailsState();
}

class _SalonDetailsState extends State<SalonDetails> {
  List<Map<String, dynamic>> selectedServices = [];
  num totalPrice = 0;

  void updateTotalPrice() {
    num newTotalPrice = 0;
    for (var service in selectedServices) {
      newTotalPrice += service['price'];
    }
    setState(() {
      totalPrice = newTotalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
        drawer: 
      
      MenuBoutton(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        
        child: Stack(
          children: <Widget>[
           Positioned.fill(
            top: MediaQuery.of(context).size.height / 3 - 250,
            right: MediaQuery.of(context).size.height / 3 - 250,
            left: MediaQuery.of(context).size.height / 3 - 250,
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
            children: <Widget>[
              Text(
           'Service Chevelure',
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 20,
             color: BbRed,
           ),
              ),
              SizedBox(height: 10),
              Column(
           children: servicechevelure.map((service) => ServiceTile(
             service: service,
             isSelected: selectedServices.contains(service),
             onTap: () {
               setState(() {
                 if (selectedServices.contains(service)) {
                   selectedServices.remove(service);
                 } else {
                   selectedServices.add(service);
                 }
                 updateTotalPrice();
               });
             },
           )).toList(),
           
           
              ),

              Text(
           'Service Onglerie',
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 20,
             color: BbRed,
           ),
              ),
              SizedBox(height: 10),
              Column(
           children: serviceonglerie.map((service) => ServiceTile(
             service: service,
             isSelected: selectedServices.contains(service),
             onTap: () {
               setState(() {
                 if (selectedServices.contains(service)) {
                   selectedServices.remove(service);
                 } else {
                   selectedServices.add(service);
                 }
                 updateTotalPrice();
               });
             },
           )).toList(),
              ),
              Text(
           'Service Corporel',
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 20,
             color: BbRed,
           ),
              ),
              SizedBox(height: 10),
              Column(
              children: servicecorporel.map((service) => ServiceTile(
             service: service,
             isSelected: selectedServices.contains(service),
             onTap: () {
               setState(() {
                 if (selectedServices.contains(service)) {
                   selectedServices.remove(service);
                 } else {
                   selectedServices.add(service);
                 }
                 updateTotalPrice();
               });
             },
              )).toList(),
              ),
              Text(
           'Service Facial',
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 20,
             color: BbRed,
           ),
              ),
              SizedBox(height: 10),
              Column(
                 children: servicefacial.map((service) => ServiceTile(
                 service: service,
                 isSelected: selectedServices.contains(service),
                 onTap: () {
                 setState(() {
                 if (selectedServices.contains(service)) {
                   selectedServices.remove(service);
                 } else {
                   selectedServices.add(service);
                 }
                 updateTotalPrice();
               });
             },
           )).toList(),
           
              ),
             Container(
             color: Colors.white.withOpacity(0.5),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                     
                         Text(
                       'Prix total:',
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 20,
                       ),
                     ),
                     Text(
                       '${totalPrice} DH',
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 18,
                       ),
                     ),
                     
                   ],
                 ),
             ),
             Center(
                     child: SizedBox(
                       height: 45,
                       width: context.screenWidth - 107,
                       child: ourButton(
                         color: BbRed,
                         title:"Poursuivre",
                         onPress: () async{
  Get.to(() =>  ReserverSalon(selectedServices: selectedServices, totalPrice: totalPrice));
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
          ],
        ),
      ),
      
      
    );
  }
}

class ServiceTile extends StatefulWidget {
  final Map<String, dynamic> service;
  final bool isSelected;
  final VoidCallback onTap;

  ServiceTile({
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
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
                  widget.service['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.isSelected ? red : Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${widget.service['duration']} Minutes',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Text(
            '${widget.service['price']} DH',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: widget.isSelected ? red : Colors.black,
            ),
          ),
          MaterialButton(
            onPressed: widget.onTap,
            color: BbPink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.isSelected ? 'Annuler' : 'Choisir',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
