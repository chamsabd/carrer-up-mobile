import 'package:pflutter/modal/Role.dart';

List<User> usersFromJson(dynamic str) =>
    List<User>.from((str).map((x) => User.fromJson(x)));

class User {
  String? id;
  String? nom;

  String? prenom;

  String? username;

  String? email;

  String? password;

  String? confirmpassword;

  String? code;

  User(
      {this.id,
      this.nom,
      this.prenom,
      this.username,
      this.email,
      this.password,
      this.confirmpassword = "",
      this.code = ""});

  factory User.fromJson(Map<String, String> json) {
    // debugPrint("roles in user " + json['roles']);
    // var list = json['roles'] as List;
    // debugPrint("roles in user " + list.toString());
    // List<Role> rolesList = list.map<Role>((i) => Role.fromJson(i)).toList();
    // //  rolesFromJson(list).toList()
    // debugPrint("roles in user " + rolesList.toString());
    return User(
        id: json['id'],
        nom: json['nom'],
        prenom: json['prenom'],
        username: json['username'] ,
        email: json['email'] ,
        password: json['password'] 
        
        //  roles: rolesList.,
        );
  }

  Map<String, String> toJson() {
    final _data = <String, String>{};

    _data['password'] = password.toString();

    if (username != null) {
      _data['username'] = username.toString();
    }
    if (id != null) {
      _data['id'] = id.toString();
    }
    if (nom != null) {
      _data['nom'] = nom.toString();
    }
    if (email != null) {
      _data['email'] = email.toString();
    }

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
