class Formation {
  final int? id;
  final String? nom;
  final String? description;
  final String? category;
  final double? prix;

  Formation(
      {required this.id,
      required this.nom,
      required this.description,
      required this.category,
      required this.prix});
//Retourne un objet json et le convertir en un objet formation
  factory Formation.fromJson(Map<String, dynamic> json) {
    return Formation(
        id: json["id"],
        nom: json["nom"],
        description: json["description"],
        category: json["category"],
        prix: json["prix"]);
  }
}
