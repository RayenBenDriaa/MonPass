import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


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
  late String id;
  late String nomPrenom;
  late String? _email;
  late String? _password;
  late String? _repeatPassword;
  late String _pathImage;
  late SharedPreferences prefs;
  late Future<bool> userinfo;

  Future<bool> getUserInfo() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id")!;
    nomPrenom=prefs.getString("nomPrenom")!;
    _email = prefs.getString("email")!;

    return true;
  }
  @override
  void initState() {
    userinfo = getUserInfo();
    super.initState();
  }




  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  //variable to use to compare password and confirm password
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final String _baseUrl = "10.0.2.2:8000";


  //Selecteur de fichier pour bouton CIN
  Future pickergalleryCIN() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(myfile!=null)
    {
      setState(() {
        _fileCIN = File(myfile.path);
      });
    }
  }

  //Selecteur de fichier pour bouton Passeport
  Future pickergalleryPasseport() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(myfile!=null)
    {
      setState(() {
        _filePasseport = File(myfile.path);
      });
    }
  }

  //Selecteur de fichier pour bouton Facture
  Future pickergalleryFacture() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(myfile!=null)
    {
      setState(() {
        _fileFacture = File(myfile.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userinfo,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData){
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
                      DrawerHeader(
                        // entête menu hamburger
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Text(nomPrenom,
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
                            Icon(Icons.help_outline),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Mes réclamations", textScaleFactor: 1.2),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/reclamationFront");
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
                        onTap: () async {
                          Navigator.pushNamed(context, "/signin");
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.clear();
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
                          const Text("Mon profil",
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
                                controller: _pass,

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
                                controller: _confirmPass,
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
                                  }else if(value != _pass.text){
                                    return "password not Matching";
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
                                String cinTextNull="";
                                String cinTextSucces="";
                                String cinTextError="";
                                String passeportTextNull="";
                                String passeportTextSucces="";
                                String passeportTextError="";
                                String factureTextNull="";
                                String factureTextSucces="";
                                String factureTextError="";

                                //verifier si les fichier ne sont pas selectionner
                                if(_fileCIN == null)
                                {
                                  cinTextNull="\n -Vous n'avez pas sélectionner de CIN !";
                                }
                                if (_filePasseport == null)
                                {
                                  passeportTextNull="\n -Vous n'avez pas sélectionner de Passeport !";
                                }
                                if(_fileFacture == null)
                                {
                                  factureTextNull="\n -Vous n'avez pas sélectionner de Facture !";
                                }

                                if(_fileCIN != null)
                                {
                                  //encoder le fichier en base64 et l'envoyer dans une requête POST au service
                                  String base64 =  base64Encode(_fileCIN.readAsBytesSync());
                                  String imageName= _fileCIN.path.split("/").last;
                                  var data = {"imageName" : imageName, "image64" : base64, "idUser" : id};
                                  var response = await http.post(Uri.http(_baseUrl, "/cin/addCinJSON"), body: data);
                                  //Si il y a une reponse du service
                                  if (response.statusCode==200 || response.statusCode==201)
                                  {
                                    cinTextSucces=response.body;
                                  }
                                  else
                                    //s'il y a erreur
                                      {
                                    cinTextError="\n -Une erreur a survenu lors de l'envoie de votre CIN!";
                                  }
                                }

                                if(_filePasseport != null)
                                {
                                  //encoder le fichier en base64 et l'envoyer dans une requête POST au service
                                  String base64 =  base64Encode(_filePasseport.readAsBytesSync());
                                  String imageName= _filePasseport.path.split("/").last;
                                  var data = {"imageName" : imageName, "image64" : base64, "idUser" : id};
                                  var response = await http.post(Uri.http(_baseUrl, "/passeport/addPasseportJSON"), body: data);
                                  //Si il y a une reponse du service
                                  if (response.statusCode==200 || response.statusCode==201)
                                  {
                                    passeportTextSucces=response.body;
                                  }
                                  else
                                    //s'il y a erreur
                                      {
                                    passeportTextError="\n -Une erreur a survenu lors de l'envoie de votre passeport!";
                                  }
                                }

                                if(_fileFacture != null)
                                {
                                  //encoder le fichier en base64 et l'envoyer dans une requête POST au service
                                  String base64 =  base64Encode(_fileFacture.readAsBytesSync());
                                  String imageName= _fileFacture.path.split("/").last;
                                  var data = {"imageName" : imageName, "image64" : base64, "idUser" : id};
                                  var response = await http.post(Uri.http(_baseUrl, "/facture/addFactureJSON"), body: data);
                                  //Si il y a une reponse du service
                                  if (response.statusCode==200 || response.statusCode==201)
                                  {
                                    factureTextSucces=response.body;
                                  }
                                  else
                                    //s'il y a erreur
                                      {
                                    factureTextError="\n -Une erreur a survenu lors de l'envoie de votre facture!";
                                  }
                                }

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return  AlertDialog(
                                        title: Text("Informations"),
                                        content: Text(cinTextNull+cinTextError+cinTextSucces
                                            +passeportTextNull+passeportTextError+passeportTextSucces
                                            +factureTextNull+factureTextError+factureTextSucces),
                                      );
                                    }
                                );
                                _fileCIN=null;
                                _fileFacture=null;
                                _filePasseport=null;
                              }

                              if(_keyForm.currentState!.validate()) {
                                _keyForm.currentState!.save();

                                Map<String, dynamic> userData = {

                                  "password": _password,


                                };
                                Map<String, String> headers = {
                                  "Content-Type": "application/json; charset=UTF-8"
                                };

                                ;
                                http.post(Uri.http(_baseUrl, '/api/EditUserJSON/${_email}', userData), headers: headers, )
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
                          )
                      ),

                    ],
                  ),
                ),
              ),
            );
          }
        else
          {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Bubbles.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child:  Scaffold(
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
                          const Text("Mon profil",
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
                            Icons.home_filled,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: Center(child: CircularProgressIndicator()),
                backgroundColor: Colors.transparent,
              ),
            );
          }
      },
    );
  }
}
