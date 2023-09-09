import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../models/user_model/user_model.dart';
import '../widgets_common/AppBar_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController textEditingController = TextEditingController();
  Map<String, dynamic> salonData = {};
    String email="";
    String name="";
    String address="";
    String phone="";
    String cartNumber="";
    String pic="";
     // Initialisation des données du salon
Future<void > fetchUserData() async {
 try{ String userId = FirebaseAuth.instance.currentUser!.uid;
print(userId);
  DocumentSnapshot<Map<String, dynamic>> salonSnapshot =
      await FirebaseFirestore.instance.collection("users").doc(userId).get();
      if(salonSnapshot.exists){setState(() {  
        email=salonSnapshot['email'];
        name=salonSnapshot['name'];
      //  address=salonSnapshot['address'];
       // phone=salonSnapshot['phone'];
        //cartNumber=salonSnapshot['cartNumber'];
        pic=salonSnapshot['image'];
         salonData = salonSnapshot.data()!;
         print(name);
});}

    print(salonData);}
catch (e){print(e);}

}
@override
  void initState() {
    fetchUserData();
    super.initState();
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: const CircleAvatar(
                      radius: 55, child: Icon(Icons.camera_alt)),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 55,
                  ),
                ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: name,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ourButton(
            title: "Update",
            onPress: () async {
              UserModel userModel = appProvider.getUserInformation
                  .copyWith(name: textEditingController.text);
              appProvider.updateUserInfoFirebase(context, userModel, image);
            },
          ),
        ],
      ),
    );
  }
}
