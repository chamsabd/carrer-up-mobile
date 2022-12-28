import 'Session.dart';

class Formation {
  late int? id;
  late String? nom;
  late String? category;
  late String? description;
  late double? prix;
  late List<Session>? sessions;

  Formation(
      {this.id,
      this.nom,
      this.description,
      this.category,
      this.sessions,
      this.prix});

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
        prix: json["prix"] as double,
        sessions: sessionList);
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nom'] = nom;
    _data['description'] = description;
    _data['category'] = category;
    _data['prix'] = prix;
    _data['sessions'] = sessions;
    return _data;
  }
}
