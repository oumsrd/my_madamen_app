import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/auth_screen/SignUp/chosescreen.dart';
import 'package:my_madamn_app/auth_screen/SignUp/signup_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';

class AddService extends StatefulWidget {
  final List<String> services;
  final List<int> personnelCount;

  AddService({
    required this.services,
    required this.personnelCount,
  });

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController servicePriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un service"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: serviceNameController,
              decoration: InputDecoration(
                labelText: "Nom du service",
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: servicePriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Prix du service",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
  onPressed: () {
    // Add the new service to the list
    String serviceName = serviceNameController.text;
    String servicePrice = servicePriceController.text;
    String newService = "$serviceName - $servicePrice€";
    setState(() {
      widget.services.add(newService);
      widget.personnelCount.add(0);
    });
  },
  style: ElevatedButton.styleFrom(
    primary: BbRed, // Change the button background color to BbPink
  ),
  child: Text("Ajouter"),
),

            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.services.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.services[index]),
                    subtitle: Text("Nombre de personnel: ${widget.personnelCount[index]}"),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 45,
                width: context.screenWidth - 107,
                child: ourButton(
                  color: BbRed,
                  title: "Continuer",
                  onPress: () {
                    // You can add your logic here to continue to the next step or navigate back to the previous screen
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
