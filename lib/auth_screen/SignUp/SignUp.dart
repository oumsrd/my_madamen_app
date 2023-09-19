import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_rim/auth_screen/Login/login_screen.dart';
import 'package:app_rim/Salon/salonSignupDetails.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../constants/constants.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';
class Signup extends StatefulWidget {
final String userType;

  const Signup({Key? key, required this.userType}) : super(key: key);
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

   
  bool isShowPassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
    TextEditingController CardNumberController = TextEditingController();

   bool rememberMeChecked = false;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
       height: double.infinity ,
        width: 500,
       
        decoration:const BoxDecoration(
         image: DecorationImage(
          image: AssetImage("assets/bgimg.jpg"),
          fit: BoxFit.cover,
        ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
              children: [
             80.heightBox,
           
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : [
                      20.heightBox,
                      Center(child: boldText(text: "Sign Up",color: BbRed)),
                       Row(children:[ 
                        20.widthBox,
                       ]),
                      20.heightBox,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: widget.userType =="salons"?"Nom du Salon":"Nom du Freelancer",
                            prefixIcon: Icon(
                  Icons.person_outline,
                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:  BbRed),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:  BbRed), // Couleur du contour lorsqu'en focus
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          ),
                          
                        ),
                      ),
                      16.heightBox,
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "E-mail ",
                            prefixIcon: Icon(
                  Icons.email_outlined,
                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:  BbRed),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:  BbRed), // Couleur du contour lorsqu'en focus
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          ),
                          
                        ),
                      ),
                       Row(children:[ 
                        20.widthBox,
                        //normalText(text:"Email",color: BbRed)
                        ]),
                    

                      Row(children:[ 
                        20.widthBox,
                       // normalText(text:"Téléphone",color: BbRed)
                        ]),
                      15.heightBox,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: TextFormField(
                          controller: phoneController,
                           keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText:"Téléphone",
                          prefixIcon: Icon(
                          Icons.phone_outlined,
                           ),  
                           border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:  BbRed),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:  BbRed), // Couleur du contour lorsqu'en focus
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          ),
                        ),
                      ),

                       Row(children:[ 
                        20.widthBox,
                      //  normalText(text:"Numéro de carte bancaire",color: BbRed)
                        ]),
                    
                      Row(children:[ 
                        20.widthBox,
                       // normalText(text:"Mot de passe ",color:BbRed)
                        ]),
                      15.heightBox,
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,    // allow only  digits
                                          CreditCardNumberFormater(),                // custom class to format entered data from textField
                                          LengthLimitingTextInputFormatter(19)       // restrict user to enter max 16 characters
                                        ],
                                        controller: CardNumberController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                             border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:BbRed), // Couleur du contour
                            ),                                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: BbRed), // Couleur du contour lorsqu'en focus
                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: BbRed),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            hintText: "Enter numéro de carte bancaire",
                                            prefixIcon:  Padding(
                                              padding: EdgeInsets.only(right:8.0),
                                              child: Icon(Icons.credit_card),
                                            ),
                                          filled: true,
                                          fillColor: Colors.white
                                        ),
                                      ),
                        ),
                        15.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: TextFormField(
                          controller:passwordController,
                         obscureText: isShowPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Mot de passe',
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:BbRed), // Couleur du contour
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: BbRed), // Couleur du contour lorsqu'en focus
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          ),
                        ),
                      ),
                      Row(children:[ 
                        20.widthBox,
                      //  normalText(text:"Confirmez le mot de passe ",color:BbRed)
                        ]),
                      15.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: TextFormField(
                          controller:confirmpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Confirmez le mot de passe',
                                prefixIcon: const Icon(
                             Icons.password_sharp,
                                ),
                                  border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color:BbRed), // Couleur du contour
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: BbRed), // Couleur du contour lorsqu'en focus
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          ),
                        ),
                      ),
                       Row(
                         children: [
                           2.widthBox,
                           Checkbox(
                             checkColor:whiteColor,
                        value: rememberMeChecked,
                       onChanged: (value) {
                      setState(() {
                      rememberMeChecked = value!;
                           });
                           },
                     activeColor: BbRed,
                            //borderSide: const BorderSide(color:BbRed), 
                            

                           ),
                           normalText(text: "Se souvenir de moi ", color: BbRed,size: 10.0),
                         

                         ],
                       ),
                       Column(children: [
                          const SizedBox(
              height: 5.0,
            ),
            const Center(child: Text("J'ai déjà un compte?",style: TextStyle(fontWeight: FontWeight.w600),)),
            const SizedBox(
              height: 2.0,
            ),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  Get.to(() =>  LoginScreen(userType: widget.userType,));

                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: BbRed,fontWeight: FontWeight.w500),
                ),
              ),
            ),
                       ],),
                      10.heightBox,
                
                     const SizedBox(height: 15),
                      Center(
                        child: SizedBox(
                          height: 45,
                          width: context.screenWidth - 107,
                          child: ourButton(
                            color: BbRed,
                            title: "Créer un compte",
                           onPress: () async {
                            print(widget.userType);
  bool isVaildated = signUpVaildation(
      emailController.text, passwordController.text, nameController.text, phoneController.text);
   String userId= FirebaseFirestore.instance.collection(widget.userType == "freelancer" ? "freelancers" : "salons").doc().id;

  if (isVaildated) {
   Get.to(() => SalonSignupDetails(
   userType: widget.userType,
   id: userId,
   name: nameController.text,
   email: emailController.text,
   phone: phoneController.text,
   password: passwordController.text,
   cartNumber: CardNumberController.text,));

  }
},

                          ),
                        ),
                      ),
                    ]
                  ).box
                  .width(300)
                  .height(680)
                  .color(Colors.white.withOpacity(0.5))
                 // .border(color: whiteColor)
                  .rounded
                  //.shadowMd
                  .padding(const EdgeInsets.all(8))
                  .make(),
                ),
              
              ],
            )
          ),
        ),
      ),
    );
  }
}
class CreditCardNumberFormater extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0){
      return newValue;
    }
    String enteredData = newValue.text;   // get data enter by used in textField
    StringBuffer buffer = StringBuffer();
    for(int i = 0;i <enteredData.length;i++){
      // add each character into String buffer
      buffer.write(enteredData[i]);
      int index = i + 1;
      if(index % 4 == 0 && enteredData.length != index){
        // add space after 4th digit
        buffer.write(" ");
      }
    }
   
    return  TextEditingValue(
      text: buffer.toString(),   // final generated credit card number
      selection: TextSelection.collapsed(offset: buffer.toString().length) // keep the cursor at end
    );
  }
}