class Inscrit {
  final int idUser;
  final DateTime date;
  final int idSession;

  Inscrit({
    required this.idUser,
    required this.date,
    required this.idSession,
  });
  factory Inscrit.fromJson(Map<String, dynamic> json) {
    return Inscrit(
      idUser: json['id'],
      date: DateTime.parse(json["date"] as String),
      idSession: json['idSession'],
    );
  }
}
