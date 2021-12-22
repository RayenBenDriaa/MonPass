import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String? _nom;
  late String? _email;
  late String? _password;
  late String? _prenom;
  late String? _numtel;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final String _baseUrl = "10.0.2.2:8000";

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator PrincipalctaWidget - INSTANCE
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Bubbles.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
              key: _keyForm,
              child: ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 100, 15, 0),
                        child: Column(
                            children: [
                              Text("S'inscrire", textAlign: TextAlign.center, style: TextStyle(
                                  color: Color.fromRGBO(18, 14, 33, 1),
                                  fontFamily: 'Red Hat Display',
                                  fontSize: 27,
                                  letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1
                              ),)

                              ,

                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 35, 10, 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Email",
                                    fillColor: Colors.white,
                                  ),
                                  onSaved: (String? value) {
                                    _email = value;
                                  },
                                  validator: (String? value) {
                                    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                    if(value == null || value.isEmpty) {
                                      return "L'adresse email ne doit pas etre vide";
                                    }
                                    else if(!RegExp(pattern).hasMatch(value)) {
                                      return "L'adresse email est incorrecte";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(), labelText: "Mot de passe"),
                                  onSaved: (String? value) {
                                    _password = value;
                                  },
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return "Le mot de passe ne doit pas etre vide";
                                    }
                                    else if(value.length < 5) {
                                      return "Le mot de passe doit avoir au moins 5 caractères";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                child: TextFormField(

                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(), labelText: "Nom"),
                                  onSaved: (String? value) {
                                    _nom = value;
                                  },
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return "le nom ne doit pas etre vide";
                                    }
                                    else if(value.length < 2) {
                                      return "le nom doit avoir au moins 2 caractères";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                child: TextFormField(

                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(), labelText: "Prenom"),
                                  onSaved: (String? value) {
                                    _prenom = value;
                                  },
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return "le prenom ne doit pas etre vide";
                                    }
                                    else if(value.length < 2) {
                                      return "Le mot de passe doit avoir au moins 2 caractères";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                child: TextFormField(

                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(), labelText: "telephone"),
                                  onSaved: (String? value) {
                                    _numtel = value;
                                  },
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return "Le num telephone ne doit pas etre vide";
                                    }
                                    else if(value.length < 8) {
                                      return "Le num telephone doit avoir au moins 8 caractères";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(_keyForm.currentState!.validate()) {
                                        _keyForm.currentState!.save();

                                        Map<String, dynamic> userData = {
                                          "nom": _nom,
                                          "password": _password,
                                          "email": _email,
                                          "prenom": _prenom,
                                          "numtel": _numtel
                                        };
                                        Map<String, String> headers = {
                                          "Content-Type": "application/json; charset=UTF-8"
                                        };

                                        ;
                                        http.post(Uri.http(_baseUrl, '/api/addUserJSON', userData), headers: headers, )
                                            .then((http.Response response) {
                                          if(response.statusCode == 200) {
                                            Navigator.pushReplacementNamed(context, "/");
                                          }
                                          else {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return const AlertDialog(
                                                    title: Text("Information"),
                                                    content: Text("Une erreur s'est produite. Veuillez réessayer !"),
                                                  );
                                                });
                                          }
                                        });

                                      }


                                    },
                                    style:  ElevatedButton.styleFrom(
                                      primary : Color(0xff00a67c),
                                    ),
                                    child: const Text("Enregistrer ",textScaleFactor: 1.1,),

                                  )
                              ),



                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children:  [
                                  const Text("Vous avez déja un compte ?"),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    child:  const Text('Cliquez ici ', style: TextStyle(color: Colors.blueAccent),),
                                    onTap: () {Navigator.pushNamed(context, "/signin");},
                                  ),
                                ],
                              ),



                            ]))]))),
    );
  }
}

/*

typedef void TextCallBack(String? value);

class TextFieldUser extends StatelessWidget {
  final String label;

  TextFieldUser({
    required this.label,
    required this.onSaved,
    Key? key,
  }) : super(key: key);
  TextCallBack onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: label),
        onSaved: (value) => onSaved(value));
  }
}
*/
