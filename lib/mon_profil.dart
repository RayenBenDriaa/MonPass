import 'package:flutter/material.dart';

class MonProfil extends StatefulWidget {
  const MonProfil({Key? key}) : super(key: key);

  @override
  State<MonProfil> createState() => _MonProfilState();
}

class _MonProfilState extends State<MonProfil> {

  late String? _email;
  late String? _password;
  late String? _repeatPassword;


  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();


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
                  Navigator.pushNamed(context, "/");
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
        body: ListView(
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
                        onPressed: (){},
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
                      onPressed: (){},
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
                      onPressed: (){},
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
                  onPressed: () {
                    if(_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();
                    }
                  },
                )
            ),

          ],
        ),
      ),
    );
  }
}
