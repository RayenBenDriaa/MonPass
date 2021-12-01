import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Accueil extends StatefulWidget {
   const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  late String etatCin;
  late String dateCin;
  late MaterialAccentColor colorCin;
  late String etatPasseport;
  late String datePasseport;
  late MaterialAccentColor colorPasseport;
  late String etatFacture;
  late String dateFacture;
  late MaterialAccentColor colorFacture;

  final String _baseUrl = "10.0.2.2:8000";

  late Future<bool> fetchedDocs;

  Future<bool> fetchDocs() async {
    //requete GET pour obtenir l'entité CIN d'un user
    http.Response response= await http.get(Uri.http(_baseUrl, "/cin/showCinJSON/"+"1"));
    //Si la réponse n'est pas vide
    if(response.body!="null")
      {
        //assigner la réponse à une MAP
        Map<String,dynamic> dataCIN = json.decode(response.body);
        //assigner les variable etat, date et couleurs à leurs valeurs correspandtes
        etatCin=dataCIN["etat"];
        if(etatCin=="En attente")
          {
            colorCin=Colors.orangeAccent;
          }
        else
          {
            colorCin=Colors.greenAccent;
          }
        dateCin="Déposé depuis le "+dataCIN["date"].toString().substring(0,10);
      }
    else
      {
        //si l'entité n'existe pas, mettre le document en tant que non déposé
        etatCin="Non déposée";
        colorCin=Colors.redAccent;
        dateCin="";
      }


    //requete GET pour obtenir l'entité Passeport d'un user
    http.Response responsePasseport= await http.get(Uri.http(_baseUrl, "/passeport/showPasseportJSON/"+"1"));
    //Si la réponse n'est pas vide
    if(responsePasseport.body!="null")
    {
      //assigner la réponse à une MAP
      Map<String,dynamic> dataPasseport = json.decode(responsePasseport.body);
      //assigner les variable etat, date et couleurs à leurs valeurs correspandtes
      etatPasseport=dataPasseport["etat"];
      if(etatPasseport=="En attente")
      {
        colorPasseport=Colors.orangeAccent;
      }
      else
      {
        colorPasseport=Colors.greenAccent;
      }
      datePasseport="Déposé depuis le "+dataPasseport["date"].toString().substring(0,10);
    }
    else
    {
      //si l'entité n'existe pas, mettre le document en tant que non déposé
      etatPasseport="Non déposée";
      colorPasseport=Colors.redAccent;
      datePasseport="";
    }

    //requete GET pour obtenir l'entité Passeport d'un user
    http.Response responseFacture= await http.get(Uri.http(_baseUrl, "/facture/showFactureJSON/"+"1"));
    //Si la réponse n'est pas vide
    if(responseFacture.body!="null")
    {
      //assigner la réponse à une MAP
      Map<String,dynamic> dataFacture = json.decode(responseFacture.body);
      //assigner les variable etat, date et couleurs à leurs valeurs correspandtes
      etatFacture=dataFacture["etat"];
      if(etatFacture=="En attente")
      {
        colorFacture=Colors.orangeAccent;
      }
      else
      {
        colorFacture=Colors.greenAccent;
      }
      dateFacture="Déposé depuis le "+dataFacture["date"].toString().substring(0,10);
    }
    else
    {
      //si l'entité n'existe pas, mettre le document en tant que non déposé
      etatFacture="Non déposée";
      colorFacture=Colors.redAccent;
      dateFacture="";
    }



    return true;
  }

  @override
  void initState() {
    fetchedDocs=fetchDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedDocs,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.hasData) {
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
                      const DrawerHeader(
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
                            Icon(Icons.addchart_rounded),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Statistique",textScaleFactor: 1.2),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/stats");
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
                            Icons.home_filled,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                backgroundColor: Colors.transparent,
                body: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 35,
                              ),
                              Text("Mes documents",
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                                  child: Row(
                                    children: [
                                      const Text("Carte d'identité nationale", textScaleFactor: 1.5),
                                      Expanded(
                                        child: Container(
                                        ),
                                      ),
                                      const Image(image: AssetImage("assets/images/id-card.jpg")),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(etatCin,
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorCin,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(dateCin,
                                      textScaleFactor: 1,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                                  child: Row(
                                    children: [
                                      const Text("Passeport", textScaleFactor: 1.5),
                                      Expanded(
                                        child: Container(
                                        ),
                                      ),
                                      const Image(image: AssetImage("assets/images/passport.jpg")),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(etatPasseport,
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorPasseport,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(datePasseport,
                                      textScaleFactor: 1,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                                  child: Row(
                                    children: [
                                      const Text("Facture STEG ou SONEDE", textScaleFactor: 1.5),
                                      Expanded(
                                        child: Container(
                                        ),
                                      ),
                                      const Image(image: AssetImage("assets/images/facture.jpg")),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(etatFacture,
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorFacture,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(dateFacture,
                                      textScaleFactor: 1,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
        }
    );
  }
}
