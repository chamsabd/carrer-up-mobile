List<Stage> stagesFromJson(dynamic str) =>
    List<Stage>.from((str).map((x) => Stage.fromJson(x)));

class Stage {
  late String? id;
  late String? societe;
  late String? sujet;
  late String? domaine;
  late DateTime? datedebut;
  late DateTime? dateFin;
  late DateTime? publishingdate = DateTime.now();
  late bool? available = true;
  late String? description;

  Stage(
      {this.id,
      this.available = true,
      this.dateFin,
      this.datedebut,
      this.description,
      this.domaine,
      this.publishingdate,
      this.societe,
      this.sujet});

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
        id: json['_id'] != null ? (json['_id'] as String?)?.toString() : null,
        societe: json['societe'] as String?,
        sujet: json['sujet'] as String?,
        domaine: json['domaine'] as String?,
        datedebut: json['datedebut'] == null
            ? null
            : DateTime.parse(json['datedebut']),
        dateFin:
            json['dateFin'] == null ? null : DateTime.parse(json['dateFin']),
        description: json['description'] as String?,
        available: json['available'] as bool?,
        publishingdate: json['publishingdate'] == null
            ? null
            : DateTime.parse(json['publishingdate']));
  }

  Map<String, String> toJson() {
    final _data = <String, String>{};
    if (id != null) {
      _data['_id'] = id.toString();
    }
    _data['societe'] = societe.toString();
    _data['sujet'] = sujet.toString();
    _data['domaine'] = domaine.toString();
    _data['datedebut'] = datedebut.toString();
    _data['dateFin'] = dateFin.toString();
    _data['description'] = description.toString();
    _data['available'] = available.toString();
    _data['publishingdate'] = publishingdate.toString();
    return _data;
  }
}
