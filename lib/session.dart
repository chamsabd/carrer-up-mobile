class Session {
  int id;
  String nom;
  int idFormation;

  Session({required this.id, required this.nom, required this.idFormation});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      nom: json['nom'],
      idFormation: json['idFormation'],
    );
  }
 
}
