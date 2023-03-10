import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:mon_pass/Model/reclamation.dart';
import 'package:mon_pass/View/backOffice/reclamation_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReclamationBack extends StatefulWidget {
  const ReclamationBack({Key? key}) : super(key: key);

  @override
  State<ReclamationBack> createState() => _ReclamationBackState();
}

class _ReclamationBackState extends State<ReclamationBack> {
  late Future<bool> fetchedReclamation;
  late String _enCours;
  late String  _traiter;
  late String _etat;


  final List<Reclamation> _reclamations = [];

  final String _baseUrl = "lencadrant.tn";
  late String nomPrenom;

  Future<bool> fetchReclamations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nomPrenom=prefs.getString("nomPrenom")!;
    IconData icone;
    Color couleur;

    http.Response response =
    await http.get(Uri.http(_baseUrl, "/reclamation/getReclamationsJSON"));

    List<dynamic> ReclamationsFromServer = json.decode(response.body);

    for (int i = 0; i < ReclamationsFromServer.length; i++) {
      if(int.parse(ReclamationsFromServer[i]["encours"].toString())==0 && int.parse(ReclamationsFromServer[i]["traite"].toString())==0)
      {
        icone= Icons.cancel_outlined;
        couleur = Colors.red;
      }
      else
      {
        if(int.parse(ReclamationsFromServer[i]["encours"].toString())==1 && int.parse(ReclamationsFromServer[i]["traite"].toString())==0)
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
          int.parse(ReclamationsFromServer[i]["id"].toString()),
          ReclamationsFromServer[i]["user"],
          ReclamationsFromServer[i]["typeReclamation"],
          ReclamationsFromServer[i]["descriptionReclamation"],
          ReclamationsFromServer[i]["dateReclamation"].substring(0, 10),
          int.parse(ReclamationsFromServer[i]["encours"].toString()),
          int.parse(ReclamationsFromServer[i]["traite"].toString()),icone,couleur));
    }

    return true;
  }

  @override
  void initState() {
    fetchedReclamation = fetchReclamations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedReclamation,
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
                  drawer: Drawer(
                    child: ListView(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: Color(0xff00a67c),
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
                              Icon(Icons.addchart_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Statistique",textScaleFactor: 1.3,
                                style: TextStyle(
                                  color : Color(0xff111113),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/back/stats");
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: const [
                              Icon(Icons.insert_drive_file),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Carte d'identit?? national",textScaleFactor: 1.3,
                                style: TextStyle(
                                  color : Color(0xff111113),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/back/cin");
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: const [
                              Icon(Icons.insert_drive_file),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Passeport",textScaleFactor: 1.3,
                                style: TextStyle(
                                  color : Color(0xff111113),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/back/passeport");
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: const [
                              Icon(Icons.insert_drive_file),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Facture",textScaleFactor: 1.3,
                                style: TextStyle(
                                  color : Color(0xff111113),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/back/facture");
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: const [
                              Icon(Icons.attach_email_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Reclamations",textScaleFactor: 1.3,
                                style: TextStyle(
                                  color : Color(0xff111113),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/back/reclamationBack");
                          },
                        ),
                        ListTile(
                          title: Row(
                            children: const [
                              Icon(Icons.exit_to_app),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Se d??connecter",textScaleFactor: 1.3,
                                style: TextStyle(
                                  color : Color(0xff111113),
                                ),
                              ),
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
                              "R??clamations",
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
                              Icons.attach_email_outlined,
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
                      Flexible(
                        // pouvoir scroller
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          //Direction du scroll
                          shrinkWrap: true,
                          //enveloppe/adapte sa taille ?? celle du contenu
                          itemCount: _reclamations.length,
                          itemBuilder: (BuildContext context, int index) {
                            if(_reclamations[index].traite==0 && _reclamations[index].enCours==0){
                              _traiter="non";
                              _etat=" Reclamation non trait??";

                            }
                            else if (_reclamations[index].traite==0 && _reclamations[index].enCours==1){
                              _traiter="oui";
                              _etat="Traitement en cours";
                            }
                            else
                            {_etat="Reclamation traiter";}

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
                                            _reclamations[index]
                                                .user["prenom"] +
                                                " " +
                                                _reclamations[index]
                                                    .user["Nom"],
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            _reclamations[index]
                                                .typeReclamation[
                                            "typereclamation"],
                                            textScaleFactor: 1.2),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            _reclamations[index]
                                                .descriptionReclamation,
                                            textScaleFactor: 1),
                                      ],
                                    ),

                                  ),
                                  InkWell(
                                      onTap: () {

                                        http.get(Uri.http(_baseUrl, "/reclamation/editReclamationJSON/${_reclamations[index].id}"));
                                        Navigator.pushNamed(context, "/back/reclamationBack");


                                      }, // Handle your callback
                                      child: new Container(
                                        margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                                        child:
                                        Row(
                                          children: [
                                            Text("Etat :   " +_etat,
                                                textScaleFactor: 1),
                                            Icon( _reclamations[index].icone
                                              , color:_reclamations[index].couleur ,),
                                            Expanded(
                                              child: Container(),
                                            ),

                                          ],
                                        ),
                                      )
                                  )

                                ],
                              ),


                            );
                          },
                        ),
                      ),

                      /*  Expanded(
                  child: ListView.builder(
                    itemCount: _reclamations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyReclaInfo(
                          _reclamations[index].id, _reclamations[index].date);
                    },
                  )

              )*/
                    ],
                  )));
        } else {
          return  Container(
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
                          "Reclamations",
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
                          Icons.attach_email_outlined,
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
      },
    );
  }
}
