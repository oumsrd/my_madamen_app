import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';

import '../../widgets/primary_button/primary_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BbPink,
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "New Password",
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
              hintText: "Confrim Password",
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
              if (newpassword.text.isEmpty) {
                showMessage("New Password is empty");
              } else if (confirmpassword.text.isEmpty) {
                showMessage("Confirm Password is empty");
              } else if (confirmpassword.text == newpassword.text) {
                FirebaseAuthHelper.instance
                    .changePassword(newpassword.text, context);
              } else {
                showMessage("Confirm Password is not match");
              }
            },
          ),
        ],
      ),
    );
  }
}