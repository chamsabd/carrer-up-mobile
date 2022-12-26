


class Stage {
  late String? id;
  late String societe;
  late String sujet;
  late String? domaine;
  late DateTime datedebut;
  late DateTime dateFin;
  late DateTime? publishingdate = DateTime.now();
  late bool? available = true;
  late String description;

  Stage(
      {this.id,
      this.available,
      required this.dateFin,
      required this.datedebut,
      required this.description,
      this.domaine,
      this.publishingdate,
      required this.societe,
      required this.sujet});

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      id: json['_id'],
      societe: json['societe'],
      sujet: json['sujet'],
      domaine: json['domaine'],
      datedebut: DateTime.parse(json['date_debut']),
      dateFin: DateTime.parse(json['dateFin']),
      description: json['description'],
      available: json['available'],
      publishingdate:DateTime.parse(json['publishingdate'])


    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
  
     _data['_id']=id;
       _data['societe']=societe;
       _data['sujet']=sujet;
       _data['domaine']=domaine;
      _data['date_debut']=datedebut;
       _data['dateFin']=dateFin;
       _data['description']=description;
       _data['available']=available;
      _data['publishingdate']=publishingdate;
    return _data;
  }
}
