import 'package:flutter/material.dart';
import 'package:app_rim/Consts/colors.dart';
import 'package:app_rim/widgets_common/AppBar_widget.dart';
import 'package:provider/provider.dart';
import '../SalonsScreen/SalonInfo.dart';
import '../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../models/salon_model/salon_model.dart';
import '../provider/app_provider.dart';
import '../widgets_common/menu_boutton.dart';


class FreelancersList extends StatefulWidget {
  final String userType;
  FreelancersList(this.userType);
  @override
   
  State<FreelancersList> createState() => _FreelancersListState();
}

class _FreelancersListState extends State<FreelancersList> {
//bool isForWomenOnly=true;
  List<SalonModel> salonModelList = [];
  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
     getFreelancerList();
    super.initState();
  }

  void getFreelancerList() async {
    setState(() {
      isLoading = true;
    });
    salonModelList = await FirebaseFirestoreHelper.instance.getFreelancers();

    salonModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
  List<SalonModel> searchList = [];
  void searchSalons(String value) {
    searchList = salonModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
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
      body:  isLoading
  ? Center(
      child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    )
  : SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            TextFormField(
              controller: search,
              onChanged: (String value) {
                searchSalons(value);
              },
              decoration: InputDecoration(hintText: "Rechercher...."),
            ),
            SizedBox(height: 24.0),
            !isSearched()
              ? const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Liste des freelancers",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : SizedBox.fromSize(),
           const  SizedBox(height: 12.0),
            search.text.isNotEmpty && searchList.isEmpty
              ? const Center(child: Text("Aucun freelancer trouvé"))
              : searchList.isNotEmpty
                  ? GridView.builder(
                      padding: EdgeInsets.only(bottom: 50),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: searchList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1,
                        crossAxisCount: 1,
                      ),
                      itemBuilder: (ctx, index) {
                        SalonModel singleProduct = searchList[index];
                        return StyledSalonCard(singleProduct,widget.userType);
                      },
                    )
                  : salonModelList.isEmpty
                      ? const Center(child: Text("Liste des freelacners est vide"))
                      : GridView.builder(
                          padding: EdgeInsets.only(bottom: 50),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: salonModelList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 1,
                            crossAxisCount: 1,
                          ),
                          itemBuilder: (ctx, index) {
                            SalonModel singleProduct = salonModelList[index];
                            return StyledSalonCard(singleProduct,widget.userType);
                          },
                        ),
           const SizedBox(height: 12.0),
          ],
        ),
      ),
    ),

    );
  }
   bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}



class StyledSalonCard extends StatelessWidget {
  final String userType;
  final SalonModel salon;

  StyledSalonCard(this.salon, this.userType);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:BbPink.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
       height: 200, // Modifiez cette valeur selon vos besoins
      width: 180,
      child: Column(
        children: [
          SizedBox(height: 10.0),
          Image.network(
            salon.image[0] ,
            height: 250,
            width: 180,
          ),
        //  SizedBox(height: 180.0),
          Text(
            salon.name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Center(child: Text("Adresse: ${salon.address}")),
          SizedBox(height: 10.0),
          SizedBox(
            height: 45,
            width: 180,
            child: OutlinedButton(
             onPressed: () {
            // Naviguez vers la page de détails du salon avec les informations pertinentes()
            Navigator.push(  context,  MaterialPageRoute( builder: (context) =>  SalonInfo(salon,userType),  ), );
          },
              child: Text("Consulter le salon",style: TextStyle(color: BbRed),),
            ),
          ),
        ],
      ),
    );
  }
}
