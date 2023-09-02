import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import '../SalonsScreen/ReserverSalon.dart';
import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/menu_boutton.dart';
import '../widgets_common/our_button.dart';



class ServicesList extends StatefulWidget {
  final stylist;
  final String userType;

  ServicesList(this.stylist, this.userType);

  @override
  _ServicesListState createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
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
           'Pack Bridal',
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 20,
             color: BbRed,
           ),
              ),
              SizedBox(height: 10),
            /*  Column(
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
           
              ),*/
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
  Get.to(() =>  ReserverSalon(salonModel: widget.stylist,selectedServices: selectedServices, totalPrice: totalPrice, reservationId:"",userType: widget.userType,));
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
