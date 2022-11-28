class Formation {
  final int? id;
  final String? nom;
  final String? description;
  final DateTime? dateDebut;
  final DateTime? dateFin;
  final int? etat;
  final int? nbrPlace;
  final double? prix;
  Formation(
      {required this.id,
      required this.nom,
      required this.description,
      required this.dateDebut,
      required this.dateFin,
      required this.etat,
      required this.nbrPlace,
      required this.prix});
//Retourne un objet json et le convertir en un objet formation
//factory
  factory Formation.fromJson(Map<String, dynamic> json) {
    return Formation(
        id: json["id"],
        nom: json["nom"],
        description: json["description"],
        dateDebut: DateTime.parse(json["dateDebut"] as String),
        dateFin: DateTime.parse(json["dateFin"] as String),
        etat: json["etat"],
        nbrPlace: json["nbrPlace"],
        prix: json["prix"]);
  }
}
