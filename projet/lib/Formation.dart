import 'Session.dart';

class Formation {
  final int? id;
  final String? nom;
  final String? category;
  final String? description;
  final double? prix;
  final List<Session> sessions;

  Formation(
      {required this.id,
      required this.nom,
      required this.description,
      required this.category,
      required this.sessions,
      required this.prix});
//Retourne un objet json et le convertir en un objet formation
  factory Formation.fromJson(Map<String, dynamic> json) {
    var list = json['sessions'] as List;
    print(list.runtimeType);
    List<Session> sessionList = list.map((i) => Session.fromJson(i)).toList();
    return Formation(
        id: json["id"],
        nom: json["nom"],
        description: json["description"],
        category: json["category"],
        prix: json["prix"],
        sessions: sessionList);
  }
}
