import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Consts/colors.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: BbYellow,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: BbYellow,
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Chargement...")),
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email déjà utilisé. Aller à la page de connexion.";
    case "account-exists-with-different-credential":
      return "Email déjà utilisé. Aller à la page de connexion.";
    case "email-already-in-use":
      return "Email déjà utilisé. Aller à la page de connexion.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Mot de passe incorrect. ";
    case "ERROR_USER_NOT_FOUND":
      return "Aucun utilisateur trouvé avec cet e-mail.";
    case "user-not-found":
      return "Aucun utilisateur trouvé avec cet e-mail.";
    case "ERROR_USER_DISABLED":
      return "Utilisateur désactivé.";
    case "user-disabled":
      return "Utilisateur désactivé.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Trop de demandes pour se connecter à ce compte.";
    case "operation-not-allowed":
      return "Trop de demandes pour se connecter à ce compte.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Trop de demandes pour se connecter à ce compte.";
    case "ERROR_INVALID_EMAIL":
      return "L’adresse e-mail n’est pas valide.";
    case "invalid-email":
      return "L’adresse e-mail n’est pas valide..";
    default:
      return "Échec de la connexion. Veuillez réessayer.";
  }
}

bool loginVaildation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Les deux champs sont vides");
    return false;
  } else if (email.isEmpty) {
    showMessage("L’e-mail est vide");
    return false;
  } else if (password.isEmpty) {
    showMessage("Le mot de passe est vide");
    return false;
  } else {
    return true;
  }
}

bool signUpVaildation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("Tous les champs sont vides");
    return false;
  } else if (name.isEmpty) {
    showMessage("Le nom est vide");
    return false;
  } else if (email.isEmpty) {
    showMessage("L'e-mail est vide");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Le téléphone est vide");
    return false;
  } else if (password.isEmpty) {
    showMessage("Le mot de passe est vide");
    return false;
  } else {
    return true;
  }
}
