List<Session> sessionFromJson(dynamic str) =>
    List<Session>.from((str).map((x) => Session.fromJson(x)));

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
    this.id,
    this.nom,
    this.idFormation,
    this.date_debut,
    this.date_fin,
    this.etat,
    this.formation_id,
    this.nbrplace,
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
  Map<String, String> toJson() {
    final _data = <String, String>{};
    if (id != null) {
      _data['_id'] = id.toString();
    }
    _data['nom'] = nom.toString();
    _data['formation_id'] = formation_id.toString();
    _data['nbr_places'] = nbrplace.toString();
    _data['date_fin'] = date_fin.toString();
    _data['date_debut'] = date_debut.toString();
    _data['etat'] = etat.toString();
    _data['idReponsable'] = idReponsable.toString();
    return _data;
  }
}
