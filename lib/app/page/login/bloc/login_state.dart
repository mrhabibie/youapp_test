part of 'login_bloc.dart';

enum LoginStatus { unknown, failure, success }

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isUsernameValid;
  final bool isPasswordValid;
  final bool isLoading;
  final LoginStatus status;

  const LoginState({
    required this.username,
    required this.password,
    this.isUsernameValid = false,
    this.isPasswordValid = false,
    this.isLoading = false,
    this.status = LoginStatus.unknown,
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool? isUsernameValid,
    bool? isPasswordValid,
    bool? isLoading,
    LoginStatus? status,
  }) =>
      LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        isUsernameValid: isUsernameValid ?? this.isUsernameValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isLoading: isLoading ?? this.isLoading,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        username,
        password,
        isUsernameValid,
        isPasswordValid,
        isLoading,
        status,
      ];
}
