import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/Pack%20Bridal/packbridalDetails.dart';
import 'package:my_madamn_app/widgets_common/AppBar_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets_common/menu_boutton.dart';

class SalonsList extends StatefulWidget {
  const SalonsList({super.key});

  @override
  State<SalonsList> createState() => _SalonsListState();
}

class _SalonsListState extends State<SalonsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      drawer: MenuBoutton(context),
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
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[],
                      ),
                    ),
                   FutureBuilder<QuerySnapshot>(
  future: FirebaseFirestore.instance
      .collection('salons')
      .get(),
  builder: (context, salonSnapshot) {
    if (salonSnapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    if (salonSnapshot.hasError) {
      return Text('Error: ${salonSnapshot.error}');
    }

    final salons = salonSnapshot.data!.docs;

    return Column(
      children: salons.map((salonDoc) {
        final salonId = salonDoc.id;
        final salonData = salonDoc.data() as Map<String, dynamic>?;

        if (salonData == null) {
          // Gérer le cas où les données du salon sont nulles
          return Container(); // Ou afficher un message d'erreur
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('packbridal')
              .where('salonId', isEqualTo: salonId)
              .snapshots(),
          builder: (context, packBridalSnapshot) {
            if (packBridalSnapshot.connectionState ==
                ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (packBridalSnapshot.hasError) {
              return Text('Error: ${packBridalSnapshot.error}');
            }

            final packBridals = packBridalSnapshot.data!.docs;

            // Afficher les informations du salon et de packbridal ici
            return Column(
              children: packBridals.map((packBridalDoc) {
                final packBridalData = packBridalDoc.data() as Map<String, dynamic>?;

                if (packBridalData == null) {
                  // Gérer le cas où les données de packbridal sont nulles
                  return Container(); // Ou afficher un message d'erreur
                }

                return StylistCard(
                  salonId: salonId,
                  salonData: salonData,
                  packBridalData: packBridalData,
                );
              }).toList(),
            );
          },
        );
      }).toList(),
    );
  },
)
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
  final String salonId;
  final Map<String, dynamic>? salonData;
  final Map<String, dynamic>? packBridalData;

  StylistCard({
    required this.salonId,
    this.salonData,
    this.packBridalData,
  });

  @override
  Widget build(BuildContext context) {
    if (salonData == null || packBridalData == null) {
      // Gérez le cas où les données sont null, par exemple, en affichant un indicateur de chargement ou un message d'erreur.
      return CircularProgressIndicator();
    }

    // Utilisez salonData! et packBridalData! pour accéder aux données en supprimant le type nullable (!).
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4 - 16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: BbYellow.withOpacity(0.5)),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 15,
            right: -2,
            child: Image.network(
              salonData!['image'][0], // Utilisez salonData! pour supprimer le type nullable
              height: 160,
              width: MediaQuery.of(context).size.width * 0.30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  salonData!['name'], // Utilisez salonData! pour supprimer le type nullable
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      salonData!['address'], // Utilisez salonData! pour supprimer le type nullable
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      salonData!['cartNumber'], // Utilisez salonData! pour supprimer le type nullable
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PackBridalDetails(salonId: salonId),
                      ),
                    );
                  },
                  color: BbRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Consulter le salon',
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
