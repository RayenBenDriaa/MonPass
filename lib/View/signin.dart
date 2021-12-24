import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  late String? _email;
  late String? _password;
  final String _baseUrl = "lencadrant.tn";
  late String role;
  late Future<bool> fetchedDocs;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  /*Future<bool> fetchUser() async {
    http.Response response= await http.get(Uri.http(_baseUrl,"/api/login/rayenbd63s@gmail.com/12345678")).then((http.Response response) {
      if(response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, "/acceuil");
        return true;
      } else if(response.statusCode == 401) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text("Information"),
                content: Text("Username et/ou mot de passe incorrect"),
              );
            });return 0;
      }else {
         showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text("Information"),
                content: Text("Une erreur s'est produite. Veuillez réessayer !"),
              );
            });
         return 0;
      }
    });
    return true;
  }*/

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
                        margin: EdgeInsets.fromLTRB(15, 150, 15, 0),
                        child: Column(
                            children: [
                              Container(
                                width: 200,
                                height: 100,
                                child:Image(
                                  image: AssetImage("assets/images/logo.png")
                                ),
                              ),
                              // Text('Se Connecter',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: Color(0xff111113),
                              //     //fontFamily: 'Red Hat Display',
                              //     fontSize: 27,
                              //     letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              //     fontWeight: FontWeight.normal,
                              //     height: 1),
                              // ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 35, 10, 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
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
                                  margin: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(_keyForm.currentState!.validate()) {
                                        _keyForm.currentState!.save();


                                      }
                                      Map<String, dynamic> userData = {
                                        "username": _email,
                                        "password" : _password
                                      };


                                      Map<String, String> headers = {
                                        "Content-Type": "application/json; charset=UTF-8"
                                      };


                                      print("test");
                                      http.get(Uri.http(_baseUrl, '/api/login/${_email}/${_password}') , )
                                          .then((http.Response response) async {
                                            print(response);
                                        if(response.body=="null" ) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const AlertDialog(
                                                  title: Text("Information"),
                                                  content: Text("Username et/ou mot de passe incorrect"),
                                                );
                                              });
                                          print("test N");
                                        }
                                        else {
                                          if (response.statusCode == 200) {
                                            print("test Y");
                                            Map<String, dynamic> userFromServer = json.decode(response.body);
                                            //saving email to shared prefs

                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setString("email", userFromServer["email"]);
                                            prefs.setString("id", userFromServer["id"].toString());
                                            prefs.setString("nomPrenom", userFromServer["prenom"]+" "+userFromServer["Nom"]);
                                            prefs.setString("role", userFromServer["roles"].toString());
                                            role=prefs.getString("role")!;
                                            print(role);
                                            debugPrint(role);
                                            if(role=="[ROLE_USER]"){
                                              Navigator.pushNamed(context,"/accueil");

                                            }else{

                                              Navigator.pushNamed(context, "/back/stats");
                                            }
                                          }
                                          else {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return const AlertDialog(
                                                    title: Text("Information"),
                                                    content: Text(
                                                        "Une erreur s'est produite. Veuillez réessayer !"),
                                                  );
                                                });
                                          }
                                        }});

                                      print("test End");

                                    },
                                    style:  ElevatedButton.styleFrom(
                                      primary : Color(0xff00a67c),
                                    ),
                                    child: const Text("Se connecter",textScaleFactor: 1.1,),

                                  )
                              ),



                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children:  [
                                  const Text("Vous n'avez pas de compte ?"),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    child:  const Text('Cliquez ici ', style: TextStyle(color: Colors.blueAccent),),
                                    onTap: () {Navigator.pushNamed(context, "/signup");},
                                  ),
                                ],
                              ),



                            ]))]))),
    );
  }
}
