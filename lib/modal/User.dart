List<User> stagesFromJson(dynamic str) =>
    List<User>.from((str).map((x) => User.fromJson(x)));

class User {
  String? id;
  String? nom;

  String? prenom;

  String? username;

  String? email;

  String? roles;

  String? password;

  String? confirmpassword;

  String? code;

  User({
    this.id,
    this.nom,
    this.prenom,
    this.username,
    this.email,
    this.roles,
    this.password,
    this.confirmpassword,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        nom: json['nom'],
        prenom: json['prenom'],
        username: json['username'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, String> toJson() {
    final _data = <String, String>{};

    _data['password'] = password.toString();

    if (username != null) {
      _data['username'] = username.toString();
    }
    if (id != null) {
      _data['_id'] = id.toString();
    }
    if (nom != null) {
      _data['nom'] = nom.toString();
    }

    _data['email'] = email.toString();

    if (prenom != null) {
      _data['prenom'] = prenom.toString();
    }

    if (confirmpassword != null) {
      _data['confirmpassword'] = confirmpassword.toString();
    }
    if (code != null) {
      _data['code'] = code.toString();
    }

    return _data;
  }
}
