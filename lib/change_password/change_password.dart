import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_rim/Consts/colors.dart';
import 'package:app_rim/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/constants.dart';
import '../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
 TextEditingController oldPassword = TextEditingController();
 Map<String, dynamic> salonData = {};
    String email="";
    String name="";
    String address="";
    String phone="";
    String cartNumber="";
    String image="";
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
        image=salonSnapshot['image'];
         salonData = salonSnapshot.data()!;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BbPink,
        title: const Text(
          "Changement de Mot de pass",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
       padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
                 200.heightBox,

          TextFormField(
      controller: oldPassword,
      obscureText: isShowPassword,
      decoration: InputDecoration(
        hintText: "Encien mot de pass",
        prefixIcon: const Icon(
      Icons.password_sharp,
        ),
      ),
      ),  const SizedBox(
            height: 24.0,
          ),
      
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Nouveau mot de pass",
              prefixIcon: const Icon(
                Icons.password_sharp,
              ),
              suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  )),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: const InputDecoration(
              hintText: "Confirmer mot de pass",
              prefixIcon: Icon(
                Icons.password_sharp,
              ),
            ),
          ),
          const SizedBox(
            height: 36.0,
          ),
         ourButton(
      title: "Update",
      onPress: () async {
        if (oldPassword.text.isEmpty) {
      showMessage("Encien mot de pass est vide");
        } else if (newpassword.text.isEmpty) {
      showMessage("Nouveau mot de pass est vide");
        } else if (confirmpassword.text.isEmpty) {
      showMessage("Confirmer mot de pass est vide");
        } else if (confirmpassword.text == newpassword.text) {
      // Vérifier l'ancien mot de passe ici
      bool isOldPasswordCorrect = await FirebaseAuthHelper.instance.verifyOldPassword(oldPassword.text);
      
      if (isOldPasswordCorrect) {
        // L'ancien mot de passe est correct, vous pouvez changer le mot de passe ici
        FirebaseAuthHelper.instance.changePassword(newpassword.text, context);
      } else {
        showMessage("Encien mot de passe est incorrect");
      }
        } else {
      showMessage("Confirmer mot de pass n'est pas le meme");
        }
      },
      ),
      
        ],
      ),
    );
  }
}
