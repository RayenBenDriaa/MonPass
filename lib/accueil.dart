import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
   const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  @override
  Widget build(BuildContext context) {
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
                          children: const [
                            Text("Validée",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Déposé depuis le jj/mm/aaaa",
                              textScaleFactor: 1,
                              style: TextStyle(
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
                          children: const [
                            Text("En Attente",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Déposé depuis le jj/mm/aaaa",
                              textScaleFactor: 1,
                              style: TextStyle(
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
                          children: const [
                            Text("Non déposée",
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("",
                              textScaleFactor: 1,
                              style: TextStyle(
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
}
