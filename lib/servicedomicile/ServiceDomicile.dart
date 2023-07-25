import 'package:flutter/material.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/servicedomicile/freelancerdetails.dart';
import 'package:my_madamn_app/widgets_common/AppBar_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets_common/menu_boutton.dart';
const freelancerData = [
  {
    'stylistName': 'Salon Amani ',
    'rating': '5.0',
    'rateAmount': '50',
    'imgUrl': 'assets/f1.jpg',
    'bgColor': BbYellow,
    'adresse':'Gueliz',
    'isForWomenOnly':true
  },
  {
    'stylistName': 'Halima Beauty ',
    'rating': '4.7',
    'rateAmount': '80',
    'imgUrl': 'assets/f2.jpg',
    'bgColor': Color(0xffEBF6FF),
    'adresse':'M Avenue',
    'isForWomenOnly':true


  },
  {
    'stylistName': 'Sanaa Cosmetics ',
    'rating': '4.9',
    'rateAmount': '70',
    'imgUrl': 'assets/f3.jpg',
    'bgColor': Color(0xffFFF3EB),
    'adresse':'Issil',
    'isForWomenOnly':false


  }
];
class ServiceDomicile extends StatefulWidget {
  @override
  State<ServiceDomicile> createState() => _ServiceDomicileState();
}

class _ServiceDomicileState extends State<ServiceDomicile> {
//bool isForWomenOnly=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      drawer: 
      
      MenuBoutton(context),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: 500,
          
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgimg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Center(
                child:  Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   
                  
                  ],
                ),
              ),
           
              Container(
                height: MediaQuery.of(context).size.height,
                width: 600,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                   
                      Text(
                        'Liste des salons',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,color: BbRed
                        ),
                      ),
                      StylistCard(freelancerData[0]),
                      StylistCard(freelancerData[1]),
                      StylistCard(freelancerData[2]),
                    ],
                  ),
                ),
              ),
            ],
          ).box
                .width(350)
                .height(1600)
                .color(Colors.white.withOpacity(0.5))
                .rounded
                .padding(const EdgeInsets.all(8))
                .make(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




class StylistCard extends StatelessWidget {
  final freelancer;
  StylistCard(this.freelancer);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4 - 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: freelancer['bgColor'],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            right: -12,
            child: Image.asset(
              freelancer['imgUrl'],height: 100,
              width: MediaQuery.of(context).size.width * 0.30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  freelancer['stylistName'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                
               
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 16,
                      color:  BbRed,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      freelancer['rating'],
                      style: TextStyle(
                        color: BbRed,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FreelancerDetails(freelancer)));
                  },
                  color: BbRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Consulter le freelancer',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

