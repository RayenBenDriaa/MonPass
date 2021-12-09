import 'package:flutter/material.dart';

class BackOffice extends StatefulWidget {
  const BackOffice({Key? key}) : super(key: key);

  @override
  State<BackOffice> createState() => _BackOfficeState();
}

class _BackOfficeState extends State<BackOffice> {

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
                    Icon(Icons.addchart_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Statistique",textScaleFactor: 1.2),
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
                    Text("Carte d'identité national",textScaleFactor: 1.2),
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
                    Text("Passeport",textScaleFactor: 1.2),
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
                    Text("Facture",textScaleFactor: 1.2),
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
                    Text("Reclamations", textScaleFactor: 1.2),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, "/back/reclamationBack");
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
                  Navigator.pushNamed(context, "/");
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
                      Text("En attente de validation",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: ()=> showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Validation de la CIN'),
                        content: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Image(image: AssetImage("assets/images/carte-identite.jpg"),),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Refuser'),
                            child: const Text('Refuser'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Accepter'),
                            child: const Text('Accepter'),
                          ),
                        ],
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Row(
                              children: [
                                const Text("Foulen Ben Foulen", textScaleFactor: 1.5),
                                Expanded(
                                  child: Container(
                                  ),
                                ),
                                const Image(image: AssetImage("assets/images/id-card.jpg")),
                              ],
                            ),
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
                  ),
                  const SizedBox(
                    width: 30,
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
