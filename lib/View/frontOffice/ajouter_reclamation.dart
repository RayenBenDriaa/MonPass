import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:mon_pass/Model/reclamation.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AjouterReclamation extends StatefulWidget {
  const AjouterReclamation({Key? key}) : super(key: key);

  @override
  State<AjouterReclamation> createState() => _AjouterReclamationState();
}

class _AjouterReclamationState extends State<AjouterReclamation> {
  final List<Reclamation> _reclamations = [];
  final List<String> _typeReclamations = [];

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  late String? _description;
  final String _baseUrl = "10.0.2.2:8000";

  late Future<bool> fetchedData;

  late String id;
  late String nomPrenom;
  late String dropdownValue;

  Future<bool> fetchData() async {

    //recuperer la session utilisateur
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id =prefs.getString("id")!;
    nomPrenom =prefs.getString("nomPrenom")!;

    //recuperer les types de réclamations à partir de la base de donnée
    http.Response responseTypeReclamation = await http
        .get(Uri.http(_baseUrl, "/typereclamation/getTypeJSON"));
    List<dynamic> TypeReclamationFromSever = json.decode(responseTypeReclamation.body);
    for (int i = 0; i < TypeReclamationFromSever.length; i++) {
      //insérer dans une liste de string les types de réclamations
      _typeReclamations.add(TypeReclamationFromSever[i]["typereclamation"]);
    }
    //assigner la valeur par défaut et la valeur de retour de la dropdown list
    dropdownValue=_typeReclamations[0];

    return true;
  }

  @override
  void initState() {
    fetchedData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedData,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Splash Screen.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  //title: const Text("Mon Passe"),
                  backgroundColor: Color(0xff00a67c),
                  toolbarHeight: 80,
                  flexibleSpace: SafeArea(
                    child: Container(
                      height: 80,
                      margin: const EdgeInsets.fromLTRB(60, 20, 20, 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Envoyer une réclamation",
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
                            Icons.help_outline,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Type de la réclamation :",textScaleFactor: 1.5,
                                style: TextStyle(
                                  color : Color(0xff111113),
                                ),),
                              SizedBox(
                                width: 10,
                              ),
                              //liste déroulante
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Color(0xff00a67c)),
                                underline: Container(
                                  height: 2,
                                  color: Colors.greenAccent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    //quand la valeur de liste change elle sera assigné au dropdownValue
                                    dropdownValue = newValue!;
                                  });
                                },
                                //insérer les élements de la list déroulante à partir de la liste récuperer dans le futur
                                items: _typeReclamations.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description :",textScaleFactor: 1.5,
                                style: TextStyle(
                                  color : Color(0xff111113),
                                ),),
                              SizedBox(
                                height: 10,
                              ),
                              Form(
                                  key: _keyForm,
                                  child: Container(
                                    width: 390,
                                    height: 80,
                                    child: TextFormField(
                                      maxLines: 4,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          ),
                                      onSaved: (String? value) {
                                        _description = value;
                                      },
                                      validator: (value) {
                                        //contrôle de saisi
                                        if (value == null || value.isEmpty) {
                                          return "La description ne doit pas etre vide";
                                        }
                                        else if (value.length < 10) {
                                          return "La description doit avoir au moins 10 caractères";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                    ),
                                  )
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: const Text("Envoyer"),
                                style:  ElevatedButton.styleFrom(
                                  primary : Color(0xff00a67c),
                                ),
                                onPressed: () async {
                                  if (_keyForm.currentState!.validate()) {
                                    _keyForm.currentState!.save();
                                    //préparation du body de la requete
                                    var data = {"idUser" : id, "description" : _description, "typeReclamation" : dropdownValue};
                                    //envoie de la requete
                                    var response = await http.post(Uri.http(_baseUrl, "/reclamation/addReclamationsJSON"), body: data);
                                    //Si il y a une reponse du service
                                    if (response.statusCode==200 || response.statusCode==201)
                                    {
                                      //actualiser la page
                                      Navigator.pushNamed(context, "/reclamationFront");
                                    }
                                    else
                                      {
                                        //message d'avertissement
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AlertDialog(
                                                title: Text("Informationn"),
                                                content: Text("Une erreur s'est produite, réessayer plus tard !"),
                                              );
                                            }
                                        );
                                      }

                                  }
                                },
                              )
                            ],
                          )
                        ],
                      ),

                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Splash Screen.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  //title: const Text("Mon Passe"),
                  backgroundColor: Color(0xff00a67c),
                  toolbarHeight: 80,
                  flexibleSpace: SafeArea(
                    child: Container(
                      height: 80,
                      margin: const EdgeInsets.fromLTRB(60, 20, 20, 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Envoyer une réclamation",
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
                            Icons.help_outline,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: Center(child: SpinKitFadingGrid(color: Color(0xff00a67c))),
                backgroundColor: Colors.transparent,
              ),
            );
          }
        });
  }
}
