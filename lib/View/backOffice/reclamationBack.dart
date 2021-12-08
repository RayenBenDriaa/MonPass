import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mon_pass/Model/reclamation.dart';
import 'package:mon_pass/View/backOffice/reclamation_info.dart';


class ReclamationBack extends StatefulWidget {
  const ReclamationBack({Key? key}) : super(key: key);

  @override
  State<ReclamationBack> createState() => _ReclamationBackState();
}

class _ReclamationBackState extends State<ReclamationBack> {
  late Future<bool> fetchedReclamation;

  final List<Reclamation> _reclamations = [];

  final String _baseUrl = "10.0.2.2:8000";

  Future<bool> fetchReclamations() async {
    http.Response response = await http.get(
        Uri.http(_baseUrl, "/reclamation/getReclamationsJSON"));

    List<dynamic> ReclamationsFromServer = json.decode(response.body);

    for (int i = 0; i < ReclamationsFromServer.length; i++) {
      _reclamations.add(Reclamation(
          int.parse(ReclamationsFromServer[i]["id"].toString()),
          ReclamationsFromServer[i]["user"],
          ReclamationsFromServer[i]["typeReclamation"],
          ReclamationsFromServer[i]["descriptionReclamation"],
          ReclamationsFromServer[i]["dateReclamation"].substring(0, 10),
          int.parse(ReclamationsFromServer[i]["encours"].toString()),
          int.parse(ReclamationsFromServer[i]["traite"].toString())));
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
        if(snapshot.hasData) {
          return Column(
            children: [

              Expanded(
                  child: ListView.builder(
                    itemCount: _reclamations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyReclaInfo(
                          _reclamations[index].id, _reclamations[index].date);
                    },
                  )

              )
            ],
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedReclamation,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData) {
          return GridView.builder(
            itemCount: _reclamations.length,
            itemBuilder: (BuildContext context, int index) {
              return MyReclaInfo(_reclamations[index].id, _reclamations[index].date);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 130
            ),
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }*/







