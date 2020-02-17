import 'package:flutter/material.dart';

class User {
  final int id;
  final String email;
  final String token;
  final String gender;
  final int date_of_birth;

  User({this.id, @required this.email, @required this.token, this.gender, this.date_of_birth});

}
