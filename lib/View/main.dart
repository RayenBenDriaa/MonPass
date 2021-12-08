import 'package:flutter/material.dart';
import 'package:mon_pass/View/backOffice/validation_facture.dart';
import 'package:mon_pass/View/backOffice/validation_passeport.dart';
import 'package:mon_pass/View/frontOffice/reclamation_front.dart';
import 'backOffice/stats.dart';
import 'backOffice/validation_cin.dart';
import 'frontOffice/accueil.dart';
import 'backOffice/back_office.dart';
import 'frontOffice/mon_profil.dart';
import 'frontOffice/signin_with.dart';
import 'package:mon_pass/View/signin.dart';
import 'package:mon_pass/View/signup.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Passe',
      routes: {
        "/": (BuildContext context) {
          return const Signin();
        },
        "/signin": (BuildContext context) {
          return const Signin();
        },
        "/signup": (BuildContext context) {
          return const Signup();
        },
        "/accueil": (BuildContext context) {
          return const Accueil();
        },
        "/profil": (BuildContext context) {
          return const MonProfil();
        },
        "/reclamationFront": (BuildContext context) {
          return const ReclamationFront();
        },
        "/back": (BuildContext context) {
          return const BackOffice();
        },
        "/back/stats": (BuildContext context) {
          return const Stats();
        },
        "/back/cin": (BuildContext context) {
          return const ValidationCin();
        },
        "/back/passeport": (BuildContext context) {
          return const ValidationPasseport();
        },
        "/back/facture": (BuildContext context) {
          return const ValidationFacture();
        },
        "/signinWith": (BuildContext context) {
          return const SigninWith();
        },
      },
    );
  }
}

