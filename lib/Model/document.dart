class Document {
  final int id;
  final int idUser;
  final String url_image;
  final String etat;
  final String date;
  final Map<String,dynamic> user;

  Document(this.id, this.idUser, this.url_image, this.etat, this.date,this.user);

  @override
  String toString() {
    return 'Document{id: $id, idUser: $idUser, url_image: $url_image, etat: $etat, date: $date, user: $user}';
  }
}