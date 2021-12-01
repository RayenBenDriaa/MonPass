import 'package:flutter/material.dart';
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
  _chartData =  getUserData();
  _chartDataP =  getUserDataP();
      super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body:SfCartesianChart(
      title: ChartTitle(text: 'Nombre de cin/passport en fonction de nombre des utilisateurs'),
      legend: Legend(isVisible:true),
      series: <ChartSeries>[LineSeries<UserData,double>(
        //Series Name
          name :'Cin',
          //getting data from our lists
          dataSource:_chartData,
          //putting data on xAxes
          xValueMapper:(UserData users,_)=>users.quantity,
          //putting data on yAxes
          yValueMapper:(UserData users,_)=>users.cinquantity,
          //showing labels
          dataLabelSettings: DataLabelSettings(isVisible:true)),LineSeries<UserDataP,double>(
          name :'Passport',
          dataSource:_chartDataP,
          xValueMapper:(UserDataP users,_)=>users.quantity,
          yValueMapper:(UserDataP users,_)=>users.pquantity,
          dataLabelSettings: DataLabelSettings(isVisible:true))],

    ),));

  }
  //adding data to our class
   List<UserData> getUserData(){
    //storing data into List
    final List<UserData> userChart =
        [
          UserData(10,5),
          UserData(15,7),
          UserData(20,11),


        ];
    return userChart;


  }

  List<UserDataP> getUserDataP(){
    final List<UserDataP> userChartP =
    [
      UserDataP(10,3),
      UserDataP(15,5),
      UserDataP(20,8),


    ];
    return userChartP;


  }

}
//creating our first class which has the cin
class UserData{
  //creating our constructor
  UserData(this.quantity,this.cinquantity);
  //our attributes
  final double quantity;
  final double cinquantity;




}
//creating our second class which has the passort
class UserDataP{
  //creating our constructor
  UserDataP(this.quantity,this.pquantity);
  //our attributes
  final double quantity;
  final double pquantity;

}
