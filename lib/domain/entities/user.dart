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
