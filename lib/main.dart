import 'package:flutter/material.dart';
import 'package:mon_pass/frontOffice/accueil.dart';
import 'package:mon_pass/backOffice/back_office.dart';
import 'package:mon_pass/frontOffice/mon_profil.dart';
import 'package:mon_pass/frontOffice/signin_with.dart';
import 'package:mon_pass/signin.dart';
import 'package:mon_pass/signup.dart';
import 'package:mon_pass/splash.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
        "/back": (BuildContext context) {
          return const BackOffice();
        },
      },
    );
  }
}


