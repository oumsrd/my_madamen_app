import 'package:my_madamn_app/client/constants/asset_images.dart';
import 'package:my_madamn_app/client/constants/routes.dart';
import 'package:my_madamn_app/client/screens/auth_ui/login/login.dart';
import 'package:my_madamn_app/client/widgets/primary_button/primary_button.dart';
import 'package:my_madamn_app/client/widgets/top_titles/top_titles.dart';
//import 'package:my_madamn_app/seller/Consts/const.dart';
import 'package:flutter/material.dart';

import '../sign_up/sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(
                subtitle: "Buy AnyItems From Using App ", title: "Welcome"),
            Center(
              child: Image.asset(
              BgImage
              ),
            ),
            
            const SizedBox(
              height: 30.0,
            ),
            PrimaryButton(
              title: "Login",
              onPressed: () {
                Routes.instance.push(widget: const Login(), context: context);
              },
            ),
            const SizedBox(
              height: 18.0,
            ),
            PrimaryButton(
              title: "Sign Up",
              onPressed: () {
                Routes.instance.push(widget: const SignUp(), context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
