class Session {
  int? id;
  String? nom;
  int? idFormation;
  DateTime? date_debut;
  DateTime? date_fin;
  int? nbrplace;
  int? idReponsable;
  String? etat;
  int? formation_id;

  Session({
    required this.id,
    required this.nom,
    required this.idFormation,
    required this.date_debut,
    required this.date_fin,
    this.etat,
    this.formation_id,
    required this.nbrplace,
    this.idReponsable,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      nom: json['nom'],
      idFormation: json['idFormation'],
      nbrplace: json['nbr_places'],
      etat: json["etat"],
      idReponsable: json["idReponsable"],
      formation_id: json["formation_id"],
      date_debut: json['date_debut'] == null
          ? null
          : DateTime.parse(json['date_debut']),
      date_fin:
          json['date_fin'] == null ? null : DateTime.parse(json['date_fin']),
    );
  }
}
