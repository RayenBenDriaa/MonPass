import 'package:flutter/material.dart';
import 'package:mon_pass/Model/user_data.dart';
import 'package:mon_pass/Model/user_data_p.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  //Creating lists
  late List<UserData> _chartData;
  late List<UserDataP> _chartDataP;

  void initState() {
//intialinsing list of Cin and passport
    _chartData = getUserData();
    _chartDataP = getUserDataP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
  }

  //adding data to our class
  List<UserData> getUserData() {
    //storing data into List
    final List<UserData> userChart = [
      UserData(10, 5),
      UserData(15, 7),
      UserData(20, 11),
    ];
    return userChart;
  }

  List<UserDataP> getUserDataP() {
    final List<UserDataP> userChartP = [
      UserDataP(10, 3),
      UserDataP(15, 5),
      UserDataP(20, 8),
    ];
    return userChartP;
  }
}
