class Demande {
  final int id;
  final DateTime date;
  final int idSession;

  Demande({
    required this.id,
    required this.date,
    required this.idSession,
  });
  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      id: json['id'],
      // date: json['date'],
      date: DateTime.parse(json["date"] as String),
      idSession: json['idSession'],
    );
  }
}
