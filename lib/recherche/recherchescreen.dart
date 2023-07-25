import 'package:flutter/material.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/widgets_common/AppBar_widget.dart';
import 'package:my_madamn_app/widgets_common/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';


import '../SalonsScreen/Salon.dart';
import '../SalonsScreen/SalonDetails.dart';

class RechercheScreen extends StatefulWidget {
  @override
  _RechercheScreenState createState() => _RechercheScreenState();
}

class _RechercheScreenState extends State<RechercheScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Salon> _filteredSalons= [];

  @override
  void initState() {
    super.initState();
    _filteredSalons = salonData;
  }

  void _filterSalon(String query) {
    setState(() {
      _filteredSalons = salonData.where((salon) => salon.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _navigateToFreelancerDetails(Salon salon) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SalonDetails(salon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    boldText(
                      text: "Rechercher un salon",
                      color: BbRed,
                      size: 20,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _filterSalon,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: BbRed),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: BbPink),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _filteredSalons.length,
                      itemBuilder: (context, index) {
                        final freelancer = _filteredSalons[index];
                        return GestureDetector(
                          onTap: () {
                            _navigateToFreelancerDetails(freelancer);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BbRed,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  freelancer.imageURL,
                                  height: 200,
                                  width: 100,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  freelancer.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ).box
                    .width(300)
                    .height(1000)
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
