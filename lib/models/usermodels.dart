// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'dart:convert';

List<UserList> userListFromJson(String str) => List<UserList>.from(json.decode(str).map((x) => UserList.fromJson(x)));

String userListToJson(List<UserList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserList {
  String name;
  String email;
  String password;
  String confirmPassword;
  int v;

  UserList({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.v,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirmPassword"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "__v": v,
  };
}
