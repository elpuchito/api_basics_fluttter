import 'package:flutter/foundation.dart';

class User {
  int id;
  String username;
  String name;
  String phone;
  String email;

  User(
      {required this.name,
      required this.phone,
      required this.id,
      required this.username,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}
