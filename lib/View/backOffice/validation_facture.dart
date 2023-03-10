import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:mon_pass/Model/document.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class ValidationFacture extends StatefulWidget {
  const ValidationFacture({Key? key}) : super(key: key);

  @override
  State<ValidationFacture> createState() => _ValidationFactureState();
}

class _ValidationFactureState extends State<ValidationFacture> {


  final List<Document> _documents = [];

  final String _baseUrl = "lencadrant.tn";

  late Future<bool> fetchedData;
  late String nomPrenom;

  Future<bool> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nomPrenom=prefs.getString("nomPrenom")!;
    http.Response response= await http.get(Uri.http(_baseUrl, "/facture/getAllFacturetJSON"));
    List<dynamic> docsFromSever = json.decode(response.body);
    print(docsFromSever);
    for (int i=0; i<docsFromSever.length; i++)
    {
      print("counter :"+i.toString());
      print(int.parse(docsFromSever[i]["id"].toString()));
      print(int.parse(docsFromSever[i]["idUser"].toString()));
      print(docsFromSever[i]["urlImage"]);
      print(docsFromSever[i]["etat"]);
      print(docsFromSever[i]["date"]);
      print(docsFromSever[i]["user"]);
      // Document doc =Document(int.parse(docsFromSever[i]["id"].toString()),docsFromSever[i]["idUser"], docsFromSever[i]["urlImage"],
      //     docsFromSever[i]["etat"], docsFromSever[i]["date"],docsFromSever[i]["user"]);
      // print(doc);
       _documents.add(Document(int.parse(docsFromSever[i]["id"].toString()),int.parse(docsFromSever[i]["idUser"].toString()), docsFromSever[i]["urlImage"],
           docsFromSever[i]["etat"], docsFromSever[i]["date"].substring(0,10),docsFromSever[i]["user"]));
      // print(_documents);
    }
    // print("________");
    print(_documents);
    // print("________");

    return true;
  }

  @override
  void initState() {
    fetchedData=fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedData,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.hasData)
          {
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
                        child: Text(nomPrenom,
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
                        children:  [
                          const Text("Facture",
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
                            Icons.insert_drive_file,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                backgroundColor: Colors.transparent,
                body: ListView.builder(
                  itemCount: _documents.length,
                  itemBuilder: (BuildContext context,int index) {
                    //return DocumentInfo(_documents[index].url_image,_documents[index].date,_documents[index].user);
                    //final item = _documents[index].toString();
                    return InkWell(
                      //key: Key(item),
                      onTap: ()=> showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Validation de la facture'),
                          content: Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: PinchZoom(
                              child: Image.network("http://"+_baseUrl+"/uploadedImages/"+_documents[index].url_image),
                              resetDuration: const Duration(milliseconds: 100),
                              maxScale: 2.5,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                http.Response response= await http.get(Uri.http(_baseUrl, "/facture/deleteFactureJSON/"+_documents[index].user["id"].toString()));
                                print(response.body);
                                if(response.statusCode != 200)
                                  {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return  AlertDialog(
                                            title: Text("Informations"),
                                            content: Text("Une erreur a survenu lors du refus du document"),
                                          );
                                        }
                                    );
                                  }
                                else
                                  {
                                    setState(() {
                                      _documents.removeAt(index);
                                    });
                                  }
                                Navigator.pop(context, 'Refuser');
                              },
                              child: const Text('Refuser'),
                            ),
                            TextButton(
                              onPressed: () async {
                                http.Response response= await http.get(Uri.http(_baseUrl, "/facture/editFactureJSON/"+_documents[index].user["id"].toString()));
                                print(response.body);
                                if(response.statusCode != 200)
                                {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return  AlertDialog(
                                          title: Text("Informations"),
                                          content: Text("Une erreur a survenu lors du refus du document"),
                                        );
                                      }
                                  );
                                }
                                else
                                {
                                  setState(() {
                                    _documents.removeAt(index);
                                  });
                                }
                                Navigator.pop(context, 'Accepter');
                              },
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
                                  Text(_documents[index].user["prenom"]+" "+_documents[index].user["Nom"], textScaleFactor: 1.5),
                                  Expanded(
                                    child: Container(
                                    ),
                                  ),
                                  Image.network("http://"+_baseUrl+"/uploadedImages/"+_documents[index].url_image,
                                    height: 100,
                                    width: 200,),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("D??pos?? depuis " +_documents[index].date,
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
                    );;
                  },
                ),
              ),
            );
          }
          else
          {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Bubbles.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child:  Scaffold(
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
                        children:  [
                          const Text("Facture",
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
                            Icons.insert_drive_file,
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
        }
    );
  }
}
