class Demande {
  final String id;
  String etat;
  final int idUser;
  final DateTime date;
  final int idSession;

  Demande({
    required this.id,
    required this.etat,
    required this.idUser,
    required this.date,
    required this.idSession,
  });
  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      id: json['_id'],
      etat: json['etat'],
      idUser: json['idUser'],
      date: DateTime.parse(json["date"] as String),
      idSession: json['idSession'],
    );
  }
}
