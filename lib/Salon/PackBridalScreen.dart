import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_rim/Consts/colors.dart';
import 'package:app_rim/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets_common/menu.dart';

class PackBridalScreen extends StatefulWidget {
  final String userType;
  PackBridalScreen({required this.userType});
  @override
  _PackBridalScreenState createState() => _PackBridalScreenState();
}

class _PackBridalScreenState extends State<PackBridalScreen> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _packNameController = TextEditingController();
  final TextEditingController _servicesController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<String> _selectedServices = [];

  void _addService() {
    String service = _servicesController.text;
    if (service.isNotEmpty) {
      setState(() {
        _selectedServices.add(service);
        _servicesController.clear();
      });
    }
  }

  void _addPackToDatabase() async {
    if (_formKey.currentState!.validate() && _selectedServices.isNotEmpty) {
      String price = _priceController.text;
 String packName = _packNameController.text;
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String salonId = user.uid;
        String? salonName = user.displayName;

        FirebaseFirestore.instance.collection('packbridal').add({
          'packName': packName,
          'salonId': salonId,
          'salonName': salonName,
          'services': _selectedServices,
          'price': price,
        });

        _servicesController.clear();
        _priceController.clear();
        setState(() {
          _selectedServices.clear();
        });
      }
    }
  }

  Widget _buildServiceList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('packbridal')
          .where('salonId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Une erreur s\'est produite');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('Aucun pack bridal enregistré pour ce salon.');
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final packData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final services = (packData['services'] as List).join(', ');
            final price = packData['price'] ;

            return ListTile(
              title: Text('Services: $services'),
              subtitle: Text('Prix total: $price'),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter Pack Bridal"),
        backgroundColor: BbRed,
      ),
      drawer: Menu(context,widget.userType),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
      controller: _packNameController,
      decoration: InputDecoration(labelText: 'Nom du pack bridal'),
    ),
    SizedBox(height: 10),
              Row(
  children: [
    Expanded(
      child: TextFormField(
        controller: _servicesController,
        decoration: InputDecoration(labelText: 'Services'),
      ),
    ),
    SizedBox(width: 10), // Un espace entre le champ de texte et le bouton
    ElevatedButton(
        onPressed: _addService,
          style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(BbRed), // Remplacez "Colors.red" par votre couleur personnalisée BbRed
  ),

  child: Text('Ajouter'),
)

  ],
),
      SizedBox(height: 10),
                Text('Services sélectionnés: ${_selectedServices.join(', ')}'),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Prix total'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le prix total';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Veuillez entrer un nombre valide';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                     height: 45,
                width: context.screenWidth - 107,
                    child: ourButton(
                      onPress: _addPackToDatabase,
                      title: 'Confirmer',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Packs Bridal enregistrés pour ce salon:'),
                _buildServiceList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
