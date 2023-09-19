import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_rim/Consts/colors.dart';
import 'package:app_rim/SalonsScreen/salondetails2.dart';
import 'package:app_rim/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/salon_model/salon_model.dart';
import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/menu_boutton.dart';
import '../widgets_common/our_button.dart';
import 'package:intl/intl.dart';

class SalonInfo extends StatefulWidget {
  final SalonModel singleSalon;
  final String userType;

  const SalonInfo(    this.singleSalon,this.userType);

  @override
  State<SalonInfo> createState() => _SalonInfoState();
}

class _SalonInfoState extends State<SalonInfo> {
  bool isFavorite=false;
   List<String> comments = []; // Liste des commentaires
  TextEditingController commentController = TextEditingController();
  String? fullName=FirebaseAuth.instance.currentUser?.displayName;
  //int qty = 1;

 late Stream<QuerySnapshot> commentsStream;

  @override
  void initState() {
    super.initState();

    commentsStream = FirebaseFirestore.instance
        .collection("commentaires")
        .where("salonId", isEqualTo: widget.singleSalon.id)
        //.orderBy("timestamp", descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>( 
      context,
    );
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Container(
      height: 400,
      child: PageView.builder(
        itemCount: widget.singleSalon.image.length,
        itemBuilder: (context, index) {
          return Image.network(
            widget.singleSalon.image[index],
            height: 400,
            width: 400,
          );
        },
      ),
      
    ),
    const SizedBox(height: 10), // Espacement entre l'image et le texte d'indication
   const Row(
      children: [
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey, // Couleur de l'icône
        ),
        SizedBox(width: 5), // Espacement entre l'icône et le texte
        Text(
          "Faites défiler pour voir plus d'images",
          style: TextStyle(
            fontSize: 12,
            ///fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),

             Row(
  children: [
    Text(
      widget.singleSalon.name,
      style: GoogleFonts.arsenal(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
    ),
    const SizedBox(height: 2,),
    Icon(
      Icons.star,
      size: 20,
      color: Colors.orange,
    ),
    Text(
      "5",
   style: GoogleFonts.arsenal(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.orange)),

    ),
    Expanded(
      child: Align(
        alignment: Alignment.centerRight, // Alignez l'icône à droite
        child: IconButton(
          onPressed: () {
            setState(() {
              widget.singleSalon.isFavourite = !widget.singleSalon.isFavourite;
            });
            if (widget.singleSalon.isFavourite) {
              appProvider.addFavouriteSalon(widget.singleSalon);
            } else {
              appProvider.removeFavouriteSalon(widget.singleSalon);
            }
          },
          icon: Icon(appProvider.getFavouriteSalonList.contains(widget.singleSalon)
              ? Icons.favorite
              : Icons.favorite_border),
        ),
      ),
    ),
  ],
),

                        // const   SizedBox(height: 5,),
                          Center(
                            child: Text(
                                 'Adresse : ${widget.singleSalon.address}',         
                                style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600))
                            ),
                          ),

            
              SizedBox(height: 5,),
          Center(
            child:Text(
              //  (widget.salonModel['isForWomenOnly'] != null && widget.salonModel['isForWomenOnly'])
                //? "Cet espace est 100% femmes":
                "Cet espace n'est pas 100% femmes",
                 style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600))
    ),
          ),
          20.heightBox,
           SizedBox(height: 10),
                         Center(
                        child: SizedBox(
                          height: 45,
                          width: context.screenWidth - 107,
                          child: ourButton(
                            color: BbRed,
                            title:"Poursuivre",
                            onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => 
                          //SalonDetails(widget.salonModel)
                          SalonDetails2(widget.singleSalon,widget.userType)
                          ));
                },
                          ),
                        ),
                      ),
                      10.heightBox,
                      Text("Commentaires :",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500)),
            // Afficher les commentaires existants
                          StreamBuilder<QuerySnapshot>(
  stream: commentsStream,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator(); // Indicateur de chargement si les données ne sont pas encore disponibles
    }

    if (snapshot.hasError) {
        print("Erreur Firestore: ${snapshot.error}");

      return Text("Une erreur s'est produite."); // Gestion des erreurs
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Text("Aucun commentaire pour le moment."); // Aucun commentaire disponible
    }

    // Affichage des commentaires
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var commentData = snapshot.data!.docs[index];
        String userName = commentData["userName"];
        String commentText = commentData["comment"];

        return ListTile(
  title: Text(
    userName,
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        commentText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
      SizedBox(height: 4), // Espacement entre le texte du commentaire et le timestamp
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          
           commentData["timestamp"] != null ? DateFormat('dd/MM/yyyy HH:mm').format(commentData["timestamp"].toDate()):"Timestamp non disponible" ,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10, // Taille de police plus petite pour le timestamp
          ),
        ),
      ),
    ],
  ),
);

      },
    );
  },
),

 SizedBox(height: 10),
     //Ajouter une commentaire                     
   Row(
  children: [
    Expanded(
      child: TextField(
        controller: commentController,
        decoration: InputDecoration(
          labelText: 'Ajouter un commentaire',
          labelStyle: TextStyle(
            color: BbRed,
          ),
        ),
      ),
    ),
    SizedBox(width: 10), // Un petit espace entre le champ de texte et le bouton
    ourButton(
  title: 'Poster',
  color: BbRed,
  onPress: () async {
    String commentText = commentController.text;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String userName = FirebaseAuth.instance.currentUser!.displayName ?? "Utilisateur";
     DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();
   String clientName=docSnapshot['name'];
    // Créer un document dans la collection "commentaires" avec les données
    await FirebaseFirestore.instance.collection("commentaires").add({
      "comment": commentText,
      "userId": userId,
      "userName": clientName,
      "salonId": widget.singleSalon.id,
      "salonName": widget.singleSalon.name,
      "timestamp": FieldValue.serverTimestamp(),
    });

    setState(() {
      comments.add(commentText);
      commentController.clear();
    });
  },
),

  ],
),
20.heightBox,
              const SizedBox(
                height: 24.0,
              ),
             
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
        
      ),
   
     ) );
  }
}
