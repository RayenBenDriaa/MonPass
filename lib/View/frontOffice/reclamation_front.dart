import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttermoji/fluttermoji.dart';
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
  final String _baseUrl = "lencadrant.tn";

  late Future<bool> fetchedData;

  late String id;
  late String nomPrenom;
  late String dropdownValue;

  bool _expanded = false;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> fetchData() async {
    //recuperer la session utilisateur
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id")!;
    nomPrenom = prefs.getString("nomPrenom")!;

    IconData icone;
    Color couleur;

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
      if(int.parse(docsFromSever[i]["encours"].toString())==0 && int.parse(docsFromSever[i]["traite"].toString())==0)
        {
          icone= Icons.cancel_outlined;
          couleur = Colors.red;
        }
      else
        {
          if(int.parse(docsFromSever[i]["encours"].toString())==1 && int.parse(docsFromSever[i]["traite"].toString())==0)
            {
              icone=Icons.access_time;
              couleur = Colors.orange;
            }
          else
            {
              icone=Icons.check;
              couleur=Colors.green;
            }
        }
      _reclamations.add(Reclamation(
          int.parse(docsFromSever[i]["id"].toString()),
          docsFromSever[i]["user"],
          docsFromSever[i]["typeReclamation"],
          docsFromSever[i]["descriptionReclamation"],
          docsFromSever[i]["dateReclamation"].substring(0, 10),
          int.parse(docsFromSever[i]["encours"].toString()),
          int.parse(docsFromSever[i]["traite"].toString()),
          icone,
          couleur));

      //print(_reclamations);
    }
    //print("________");
    print(_reclamations);
    //print("________");

    //recuperer les types de réclamations à partir de la base de donnée
    http.Response responseTypeReclamation =
        await http.get(Uri.http(_baseUrl, "/typereclamation/getTypeJSON"));
    List<dynamic> TypeReclamationFromSever =
        json.decode(responseTypeReclamation.body);
    for (int i = 0; i < TypeReclamationFromSever.length; i++) {
      //insérer dans une liste de string les types de réclamations
      _typeReclamations.add(TypeReclamationFromSever[i]["typereclamation"]);
    }
    //assigner la valeur par défaut et la valeur de retour de la dropdown list
    dropdownValue = _typeReclamations[0];

    return true;
  }

  @override
  void initState() {
    fetchedData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = (MediaQuery.of(context).size.width)*0.4;
    return FutureBuilder(
        future: fetchedData,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Bubbles.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                key: scaffoldKey,
                drawer: Drawer(
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(0xff00a67c),
                        ),
                        child: Container(
                          child: Column(
                            children: [
                              FluttermojiCircleAvatar(
                                backgroundColor: Color(0xfff4f4ed),
                                radius: 45,
                              ),
                              Text(
                                nomPrenom,
                                textScaleFactor: 2,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),

                            ],
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
                            Text("Accueil",textScaleFactor: 1.3,
                              style: TextStyle(
                                color : Color(0xff111113),
                              ),),
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
                            Text("Mon profil",textScaleFactor: 1.3,
                              style: TextStyle(
                                color : Color(0xff111113),
                              ),
                            ),
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
                            Text("Mes réclamations", textScaleFactor: 1.3,
                              style: TextStyle(
                                color : Color(0xff111113),
                              ),),
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
                            Text("Se déconnecter",textScaleFactor: 1.3,
                              style: TextStyle(
                                color : Color(0xff111113),
                              ),),
                          ],
                        ),
                        onTap: () async {
                          Navigator.pushNamed(context, "/signin");
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove("email");
                          prefs.remove("id");
                          prefs.remove("nomPrenom");
                          prefs.remove("role");
                        },

                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  //title: const Text("Mon Passe"),
                  leading: IconButton(
                    icon: Image.asset("assets/images/icons8-menu-cerclé-48.png", height: 30, width: 30,),
                    onPressed: () => scaffoldKey.currentState?.openDrawer(),
                  ),
                  backgroundColor: Color(0xff00a67c),
                  toolbarHeight: 80,
                  flexibleSpace: SafeArea(
                    child: Container(
                      height: 80,
                      margin: const EdgeInsets.fromLTRB(60, 20, 20, 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          const Text("Mes réclamations",
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
                  scrollDirection: Axis.vertical,
                  //Direction du scroll
                  shrinkWrap: true,
                  //enveloppe/adapte sa taille à celle du contenu
                  itemCount: _reclamations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      color: Color(0xff00a67c),
                      child: ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 500),
                        children: [
                          ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width : c_width,
                                    child: Text(
                                        //afficher le type de la réclamation
                                        _reclamations[index]
                                            .typeReclamation["typereclamation"],
                                        textScaleFactor: 1.5),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Text(_reclamations[index].date,
                                      textScaleFactor: 1),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon( _reclamations[index].icone
                                  , color:_reclamations[index].couleur ,),
                                ],
                              );
                            },
                            body: ListTile(
                              title: Text(
                                                //afficher la description de la reclamation
                                                  _reclamations[index].descriptionReclamation,
                                                  textScaleFactor: 1),
                            ),
                            isExpanded: _reclamations[index].isExpanded,
                            canTapOnHeader: true,
                          ),
                        ],
                        dividerColor: Colors.grey,
                        expansionCallback: (panelIndex, isExpanded) {
                          _reclamations[index].isExpanded =
                              !_reclamations[index].isExpanded;
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/ajouterReclamation");
                  },
                  backgroundColor: Color(0xff00a67c),
                  child: const Icon(Icons.add),
                ),
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Bubbles.png'),
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
                body: Center(child: SpinKitFadingGrid(color: Color(0xff00a67c))),
                backgroundColor: Colors.transparent,
              ),
            );
          }
        });
  }
}

