import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mon_pass/Model/reclamation.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ReclamationFront extends StatefulWidget {
  const ReclamationFront({Key? key}) : super(key: key);

  @override
  State<ReclamationFront> createState() => _ReclamationFrontState();
}

class _ReclamationFrontState extends State<ReclamationFront> {
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

    //Recuperer les reclamation du user connecté
    http.Response response = await http
        .get(Uri.http(_baseUrl, "/reclamation/getReclamationsJSONBy/" + id));
    List<dynamic> docsFromSever = json.decode(response.body);
    print("________");
    for (int i = 0; i < docsFromSever.length; i++) {
      // print("counter :" + i.toString());
      // print(int.parse(docsFromSever[i]["id"].toString()));
      // print(docsFromSever[i]["user"]);
      // print(docsFromSever[i]["typeReclamation"]);
      // print(docsFromSever[i]["descriptionReclamation"]);
      // print(docsFromSever[i]["dateReclamation"].substring(0, 10));
      // print(int.parse(docsFromSever[i]["encours"].toString()));
      // print(int.parse(docsFromSever[i]["traite"].toString()));
      // Reclamation doc = Reclamation(
      //     int.parse(docsFromSever[i]["id"].toString()),
      //     docsFromSever[i]["user"],
      //     docsFromSever[i]["typeReclamation"],
      //     docsFromSever[i]["descriptionReclamation"],
      //     docsFromSever[i]["dateReclamation"].substring(0, 10),
      //     int.parse(docsFromSever[i]["encours"].toString()),
      //     int.parse(docsFromSever[i]["traite"].toString()));
      // print(doc);

      //ajouter dans la liste les reclamations récupéré par la BD
      _reclamations.add(Reclamation(
          int.parse(docsFromSever[i]["id"].toString()),
          docsFromSever[i]["user"],
          docsFromSever[i]["typeReclamation"],
          docsFromSever[i]["descriptionReclamation"],
          docsFromSever[i]["dateReclamation"].substring(0, 10),
          int.parse(docsFromSever[i]["encours"].toString()),
          int.parse(docsFromSever[i]["traite"].toString())));

      //print(_reclamations);
    }
    //print("________");
    print(_reclamations);
    //print("________");

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
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Text(
                          nomPrenom,
                          textScaleFactor: 2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: const [
                            Icon(Icons.home),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Accueil", textScaleFactor: 1.2),
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
                            Text("Mon profil", textScaleFactor: 1.2),
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
                            Text("Se déconnecter", textScaleFactor: 1.2),
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
                        children: [
                          const Text(
                            "Mes réclamations",
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
                body: ListView.builder(
                  scrollDirection: Axis.vertical, //Direction du scroll
                  shrinkWrap: true, //enveloppe/adapte sa taille à celle du contenu
                  itemCount: _reclamations.length,
                  itemBuilder: (BuildContext context, int index) {
                    //return DocumentInfo(_documents[index].url_image,_documents[index].date,_documents[index].user);
                    //final item = _documents[index].toString();
                    return Card(
                      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Row(
                              children: [
                                Text(
                                  // le nom et prenom de la personne qui a envoyé la réclamation
                                    _reclamations[index].user["prenom"] +
                                        " " +
                                        _reclamations[index].user["Nom"],
                                    textScaleFactor: 1.5),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(_reclamations[index].date,
                                    textScaleFactor: 1),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //afficher le type de la réclamation
                                    _reclamations[index]
                                        .typeReclamation["typereclamation"],
                                    textScaleFactor: 1.2),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  //afficher la description de la reclamation
                                    _reclamations[index].descriptionReclamation,
                                    textScaleFactor: 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/ajouterReclamation");
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add),
                ),
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Bubbles.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
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
                        children: [
                          const Text(
                            "Mes réclamations",
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
                body: Center(child: CircularProgressIndicator()),
                backgroundColor: Colors.transparent,
              ),
            );
          }
        });
  }
}
