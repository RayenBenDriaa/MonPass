import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MonProfil extends StatefulWidget {
  const MonProfil({Key? key}) : super(key: key);

  @override
  State<MonProfil> createState() => _MonProfilState();
}

class _MonProfilState extends State<MonProfil> {
  var _fileCIN;
  var _filePasseport;
  var _fileFacture;
  //late File _fileFacture;
  late String? _email;
  late String? _password;
  late String? _repeatPassword;
  late String _pathImage;



  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final String _baseUrl = "10.0.2.2:8000";


 //Selecteur de fichier pour bouton CIN
  Future pickergalleryCIN() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _fileCIN = File(myfile!.path);
    });
  }

  //Selecteur de fichier pour bouton Passeport
  Future pickergalleryPasseport() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _filePasseport = File(myfile!.path);
    });
  }

  //Selecteur de fichier pour bouton Facture
  Future pickergalleryFacture() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _fileFacture = File(myfile!.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      //Mise en place arriére plan
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Bubbles.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                // entête menu hamburger
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text('Foulen Ben Foulen',
                  textScaleFactor: 2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              //les elements du menu hamburger
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.home),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Accueil",textScaleFactor: 1.2),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/accueil");
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.account_circle_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Mon profil",textScaleFactor: 1.2),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/profil");
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Se déconnecter",textScaleFactor: 1.2),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/back");
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          //title: const Text("Mon Passe"),
          backgroundColor: Colors.green,
          toolbarHeight: 80,
          flexibleSpace: SafeArea(
            child: Container(
              height: 80,
              margin: const EdgeInsets.fromLTRB(60, 20, 20, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  const Text("Mon Passe",
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                    ),
                  ),
                  const Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

          ),
        ),
        backgroundColor: Colors.transparent,
        body: Form(
            key: _keyForm,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Repeter le mot de passe"),
                        onSaved: (String? value) {
                          _repeatPassword = value;
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
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: OutlinedButton(
                          onPressed: pickergalleryCIN,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              children: [
                                const Text("Carte d'identité nationale",textScaleFactor: 1.1,),
                                Expanded(
                                  child: Container(
                                  ),
                                ),
                                const Icon(Icons.upload_rounded),
                              ],
                            ),
                          ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: OutlinedButton(
                        onPressed: pickergalleryPasseport,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: [
                              const Text("Passeport",textScaleFactor: 1.1,),
                              Expanded(
                                child: Container(
                                ),
                              ),
                              const Icon(Icons.upload_rounded),
                            ],
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: OutlinedButton(
                        onPressed: pickergalleryFacture,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: [
                              const Text("Facture STEG ou SONEDE",textScaleFactor: 1.1,),
                              Expanded(
                                child: Container(
                                ),
                              ),
                              const Icon(Icons.upload_rounded),
                            ],
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(100, 20, 100, 0),
                  child: ElevatedButton(
                    style:  ElevatedButton.styleFrom(
                      primary : Colors.green,
                    ),
                    child: const Text("Enregistrer",textScaleFactor: 1.1,),
                    onPressed: () async{
                      //if(_keyForm.currentState!.validate()) {
                      if(true) {
                        _keyForm.currentState!.save();

                        //verifier si le fichier n'est pas selectionner
                        if(_fileCIN == null)
                          {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text("Informations"),
                                    content: Text("Vous n'avez pas sélectionner de CIN !"),
                                  );
                                }
                            );
                          }
                        else
                          {
                            //encoder le fichier en base64 et l'envoyer dans une requête POST au service
                            String base64 =  base64Encode(_fileCIN.readAsBytesSync());
                            String imageName= _fileCIN.path.split("/").last;
                            var data = {"imageName" : imageName, "image64" : base64, "idUser" : "1"};
                            var response = await http.post(Uri.http(_baseUrl, "/cin/addCinJSON"), body: data);
                            //Si il y a une reponse du service
                            if (response.statusCode==200 || response.statusCode==201)
                              {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return  AlertDialog(
                                        title: const Text("Informations"),
                                        content: Text(response.body),
                                      );
                                    }
                                );
                              }
                            else
                              //s'il y a erreur
                              {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialog(
                                        title: Text("Informations"),
                                        content: Text("Une erreur a survenu !"),
                                      );
                                    }
                                );
                              }
                          }

                        //verifier si le fichier n'est pas selectionner
                        if(_filePasseport == null)
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text("Informations"),
                                  content: Text("Vous n'avez pas sélectionner de Passeport !"),
                                );
                              }
                          );
                        }
                        else
                        {
                          //encoder le fichier en base64 et l'envoyer dans une requête POST au service
                          String base64 =  base64Encode(_filePasseport.readAsBytesSync());
                          String imageName= _filePasseport.path.split("/").last;
                          var data = {"imageName" : imageName, "image64" : base64, "idUser" : "1"};
                          var response = await http.post(Uri.http(_baseUrl, "/passeport/addPasseportJSON"), body: data);
                          //Si il y a une reponse du service
                          if (response.statusCode==200 || response.statusCode==201)
                          {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return  AlertDialog(
                                    title: const Text("Informations"),
                                    content: Text(response.body),
                                  );
                                }
                            );
                          }
                          else
                            //s'il y a erreur
                              {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text("Informations"),
                                    content: Text("Une erreur a survenu !"),
                                  );
                                }
                            );
                          }
                        }


                        //verifier si le fichier n'est pas selectionner
                        if(_fileFacture == null)
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text("Informations"),
                                  content: Text("Vous n'avez pas sélectionner de Facture !"),
                                );
                              }
                          );
                        }
                        else
                        {
                          //encoder le fichier en base64 et l'envoyer dans une requête POST au service
                          String base64 =  base64Encode(_fileFacture.readAsBytesSync());
                          String imageName= _fileFacture.path.split("/").last;
                          var data = {"imageName" : imageName, "image64" : base64, "idUser" : "1"};
                          var response = await http.post(Uri.http(_baseUrl, "/facture/addFactureJSON"), body: data);
                          //Si il y a une reponse du service
                          if (response.statusCode==200 || response.statusCode==201)
                          {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return  AlertDialog(
                                    title: const Text("Informations"),
                                    content: Text(response.body),
                                  );
                                }
                            );
                          }
                          else
                            //s'il y a erreur
                              {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text("Informations"),
                                    content: Text("Une erreur a survenu !"),
                                  );
                                }
                            );
                          }
                        }
                        


                      }
                    },
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
