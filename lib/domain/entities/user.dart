import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String username;
  final String password;
  final String? name;
  final String? gender;
  final DateTime? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;

  const User({
    required this.email,
    required this.username,
    required this.password,
    this.name,
    this.gender,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.height,
    this.weight,
  });

  // Empty user which represents an unauthenticated User.
  static const empty = User(
    email: 'unknown@mail.com',
    username: 'unknown',
    password: 'blablabla',
  );

  // Convenience getter to determine whether the current User is empty.
  bool get isEmpty => this == User.empty;

  // Convenience getter to determine whether the current User is not empty.
  bool get isNotEmpty => this != User.empty;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"] ?? "unknown@mail.com",
        username: json["username"] ?? "unknown",
        password: json["password"] ?? "unknown",
        name: json["name"] ?? "unknown",
        gender: json["gender"] ?? "unknown",
        birthday: DateTime.tryParse(json["birthday"]) ?? DateTime(1945, 08, 17),
        horoscope: json["horoscope"] ?? "unknown",
        zodiac: json["zodiac"] ?? "unknown",
        height: json["height"] ?? 0,
        weight: json["weight"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "email": email ?? "",
        "username": username ?? "",
        "password": password ?? "",
        "name": name ?? "",
        "gender": gender ?? "",
        "birthday": birthday?.toIso8601String() ?? "",
        "horoscope": horoscope ?? "",
        "zodiac": zodiac ?? "",
        "height": height ?? 0,
        "weight": weight ?? 0,
      };

  @override
  List<Object?> get props => [
        email,
        username,
        password,
        name,
        gender,
        birthday,
        horoscope,
        zodiac,
        height,
        weight,
      ];
}
