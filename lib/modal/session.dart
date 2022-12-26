class Session {
  int? id;
  String nom;
  int idFormation;
  DateTime? date_debut;
  DateTime? date_fin;
  int nbrplace;

  Session(
      {required this.id,
      required this.nom,
      required this.idFormation,
      this.date_debut,
      this.date_fin,
     required  this.nbrplace});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      nom: json['nom'],
      idFormation: json['idFormation'],
      nbrplace: json['nbr_places'],
      date_debut:json['date_debut']==null?null: DateTime.parse(json['date_debut'] ),
      date_fin:json['date_fin']==null?null: DateTime.parse(json['date_fin']),
    );
  }
}
