

import 'package:flutter/cupertino.dart';

class Reclamation {
  final int id;
  final Map<String,dynamic> user;
  final Map<String,dynamic> typeReclamation;
  final String descriptionReclamation;
  final String date;
  final int enCours;
  final int traite;
  final IconData icone;
  final Color couleur;
  bool isExpanded=false;


  Reclamation(this.id, this.user, this.typeReclamation,
      this.descriptionReclamation, this.date, this.enCours, this.traite,this.icone,this.couleur);

  @override
  String toString() {
    return 'Reclamation{id: $id, user: $user, typeReclamation: $typeReclamation, descriptionReclamation: $descriptionReclamation, date: $date, enCours: $enCours, traite: $traite}';
  }
}
