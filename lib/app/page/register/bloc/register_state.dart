part of 'register_bloc.dart';

enum RegisterStatus { unknown, failure, success }

class RegisterState extends Equatable {
  final String email;
  final bool isValidEmail;
  final String username;
  final bool isValidUsername;
  final String password;
  final String confirmPassword;
  final bool isValidPassword;
  final RegisterStatus status;

  const RegisterState({
    required this.email,
    this.isValidEmail = false,
    required this.username,
    this.isValidUsername = false,
    required this.password,
    required this.confirmPassword,
    this.isValidPassword = false,
    this.status = RegisterStatus.unknown,
  });

  RegisterState copyWith({
    String? email,
    bool? isValidEmail,
    String? username,
    bool? isValidUsername,
    String? password,
    String? confirmPassword,
    bool? isValidPassword,
    RegisterStatus? status,
  }) =>
      RegisterState(
        email: email ?? this.email,
        isValidEmail: isValidEmail ?? this.isValidEmail,
        username: username ?? this.username,
        isValidUsername: isValidUsername ?? this.isValidUsername,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isValidPassword: isValidPassword ?? this.isValidPassword,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        email,
        isValidEmail,
        username,
        isValidUsername,
        password,
        confirmPassword,
        isValidPassword,
        status,
      ];
}
