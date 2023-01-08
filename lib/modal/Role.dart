List<Role> rolesFromJson(dynamic str) =>
    List<Role>.from((str).map((x) => Role.fromJson(x)));

class Role {
  late String? id;
  late String? name;

  Role({
    this.id,
    this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, String> toJson() {
    final _data = <String, String>{};

    if (id != null) {
      _data['id'] = id.toString();
    }
    if (name != null) {
      _data['name'] = name.toString();
    }

    return _data;
  }
}
