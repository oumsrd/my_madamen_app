import 'package:flutter/material.dart';

import '../Consts/colors.dart';
class CurrentLocationDialog extends StatelessWidget {
  final Function onPressed;

  CurrentLocationDialog({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Est-ce que vous voulez utiliser votre adresse actuelle ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => onPressed(),
                style: ElevatedButton.styleFrom(primary: BbRed),
                child: Text("Utiliser l'adresse actuelle"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
