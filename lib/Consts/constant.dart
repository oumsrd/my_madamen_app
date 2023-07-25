//import 'package:e_commerce/models/cartModal.dart';
import 'package:flutter/material.dart';

//import 'models/categoryModal.dart';
//import 'models/paymentModal.dart';
//import 'models/recommendedModal.dart';
//import 'models/reviewModal.dart';
//import 'models/trackOrderModal.dart';

const kPrimaryColor = Color.fromARGB(255, 100, 21, 255);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
const kLess = 4.0;

const kShape = 30.0;

const kRadius = 0.0;
const kAppBarHeight = 56.0;

const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);

const kDivider = Divider(
  color: kAccentColor,
  thickness: kLessPadding,
);

const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 5.0,
);

const String pieChart = 'assets/images/pieChart.png';
const String trophy = 'assets/images/trophy.png';
const String chat = 'assets/images/chat.png';
const String whiteShape = 'assets/images/whitebg.svg';
const String logo = 'assets/images/shoppingBag.png';
const String profile = 'assets/images/profile.jpg';
const String bg = 'assets/images/background.jpg';
const String manShoes = 'assets/images/manShoes.jpg';
const String success = 'assets/success.gif';
const String chatBubble = 'assets/images/emptyChat.png';
const String emptyOrders = 'assets/images/orders.png';
const String callCenter = 'assets/images/center.png';
const String conversation = 'assets/images/conversation.png';

List<Map<String, String>> introData = [
  {
    'image': pieChart,
    'headText': 'Track your routine',
    'descText':
        "Whether it's sets, reps, weight used, you can track it all with our intuitive interface.",
  },
  {
    'image': trophy,
    'headText': 'Set personal goals',
    'descText':
        "We're all in the gym for a reason: goals. set goals for diet and fitness.",
  },
  {
    'image': chat,
    'headText': 'Chat with others',
    'descText': "Inspire and help each other reach fitness and diet goals.",
  },
];

final labels = [
  'Notifications',
  'Payments',
  'Message',
  'My Orders',
  'Setting Account',
  'Call Center',
  'About Application',
];

final icons = [
  Icons.notifications,
  Icons.payment,
  Icons.message,
  Icons.local_dining,
  Icons.settings,
  Icons.person,
  Icons.info,
];
final ListCreanciers = [
  'IAM RECHARGES',
  'REDAL',
  'IAM FACTURES',
  'AMENDIS TANGER'
];
final idlist = [1, 2, 3];
const payIcon = 'assets/pay.png', billsIcon = 'assets/bills.png';
final rechargeList = [10.0, 20.0, 30.0, 50.0, 100.0];
final offremList = [
  '(*1) 2h valable 3j d' 'appels nationaux',
  '(*2) 1H ou 1 GO 7j de validité',
  '(*3) 1Go valable 7j'
];
List<List<String>> offresList = [
  // Liste d'offres pour le premier opérateur
  [
    'Offre 1 Opérateur 1',
    'Offre 2 Opérateur 1',
    'Offre 3 Opérateur 1',
  ],
  // Liste d'offres pour le deuxième opérateur
  [
    'Offre 1 Opérateur 2',
    'Offre 2 Opérateur 2',
    'Offre 3 Opérateur 2',
  ],
  // Ajoutez les autres listes d'offres pour les autres opérateurs ici
];

final rechargeLabels = ['INWI', 'IAM', 'ORANGE'];
final rechargeIcons = [
  'assets/inwi.png',
  'assets/maroc.jpg',
  'assets/orange.png'
];
final paymentLabels = ['Credit card / Debit card'];

final paymentIcons = [Icons.credit_card];