import 'package:flutter/foundation.dart';


final class User {
  String name;

  User({required this.name});

  factory User.initial() => User(name: '');
}
