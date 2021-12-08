class Reclamation {
  final int id;
  final Map<String,dynamic> user;
  final Map<String,dynamic> typeReclamation;
  final String descriptionReclamation;
  final String date;
  final int enCours;
  final int traite;

  Reclamation(this.id, this.user, this.typeReclamation,
      this.descriptionReclamation, this.date, this.enCours, this.traite);

  @override
  String toString() {
    return 'Reclamation{id: $id, user: $user, typeReclamation: $typeReclamation, descriptionReclamation: $descriptionReclamation, date: $date, enCours: $enCours, traite: $traite}';
  }
}