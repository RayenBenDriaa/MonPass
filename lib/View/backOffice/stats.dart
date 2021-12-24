import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mon_pass/Model/user_data.dart';
import 'package:mon_pass/Model/user_data_p.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  //Creating lists
  late List<UserData> _chartData;
  late List<UserDataP> _chartDataP;
  late Future<bool> fetchedStat;
  late double countuser, countpass, countcin;
  final String _baseUrl = "lencadrant.tn";
  late String nomPrenom;

  Future<bool> fetcheduser() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    nomPrenom=prefs.getString("nomPrenom")!;

    http.Response response =
    await http.get(Uri.http(_baseUrl, "/api/countUserJson"));
    http.Response response1 =
    await http.get(Uri.http(_baseUrl, "/passeport/countPassportJson"));
    http.Response response2 =
    await http.get(Uri.http(_baseUrl, "/cin/countCinJson"));

    countuser = double.parse(json.decode(response.body).toString());
    countpass = double.parse(json.decode(response2.body).toString());
    countcin = double.parse(json.decode(response1.body).toString());
    print(countuser);
    _chartData = getUserData();
    _chartDataP = getUserDataP();

    return true;
  }








  void initState() {
//intialinsing list of Cin and passport

    fetchedStat = fetcheduser();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedStat,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
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
                            Text("Carte d'identité national",textScaleFactor: 1.3,
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
                            Text("Se déconnecter",textScaleFactor: 1.3,
                              style: TextStyle(
                                color : Color(0xff111113),
                              ),
                            ),
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
                  backgroundColor: Color(0xff00a67c),
                  toolbarHeight: 80,
                  flexibleSpace: SafeArea(
                    child: Container(
                      height: 80,
                      margin: const EdgeInsets.fromLTRB(60, 20, 20, 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          const Text("Statistique",
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
                            Icons.addchart_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                body: SfCartesianChart(
                  title: ChartTitle(
                      text:
                      'Nombre de cin/passport en fonction de nombre des utilisateurs'),
                  legend: Legend(isVisible: true),
                  series: <ChartSeries>[
                    LineSeries<UserData, double>(
                      //Series Name
                        name: 'Cin',
                        //getting data from our lists
                        dataSource: _chartData,
                        //putting data on xAxes
                        xValueMapper: (UserData users, _) => users.quantity,
                        //putting data on yAxes
                        yValueMapper: (UserData users, _) => users.cinquantity,
                        //showing labels
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                    LineSeries<UserDataP, double>(
                        name: 'Passport',
                        dataSource: _chartDataP,
                        xValueMapper: (UserDataP users, _) => users.quantity,
                        yValueMapper: (UserDataP users, _) => users.pquantity,
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ],
                ),
              ));

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
                          "Statistique",
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
                          Icons.addchart_rounded,
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

  //adding data to our class
  List<UserData> getUserData() {


    //storing data into List
    final List<UserData> userChart = [
      UserData(countuser - 6, countcin - 1),
      UserData(countuser - 3, countcin - 1),
      UserData(countuser, countcin),
    ];
    return userChart;
  }

  List<UserDataP> getUserDataP() {
    final List<UserDataP> userChartP = [
      UserDataP(countuser - 6, countpass - 1),
      UserDataP(countuser - 3, countpass - 1),
      UserDataP(countuser, countpass),
    ];
    return userChartP;
  }
}
