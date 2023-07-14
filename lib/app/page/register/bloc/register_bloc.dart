import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:youapp_test/data/repositories/authentication_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository _authenticationRepository;

  RegisterBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const RegisterState(
          email: '',
          username: '',
          password: '',
          confirmPassword: '',
        )) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmited>(_onSubmitted);
  }

  void _onEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) {
    final email = event.email;
    emit(state.copyWith(
      email: email,
      isValidEmail: email.isNotEmpty &&
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(email),
    ));
  }

  void _onUsernameChanged(
      RegisterUsernameChanged event, Emitter<RegisterState> emit) {
    final username = event.username;
    emit(state.copyWith(
      username: username,
      isValidUsername: username.isNotEmpty && username.length >= 3,
    ));
  }

  void _onPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    final password = event.password;

    emit(state.copyWith(
      password: password,
      isValidPassword: password.isNotEmpty &&
          state.confirmPassword.isNotEmpty &&
          (state.confirmPassword.compareTo(password) == 0),
    ));
  }

  void _onConfirmPasswordChanged(
      RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) {
    final confirmPassword = event.confirmPassword;

    emit(state.copyWith(
      confirmPassword: confirmPassword,
      isValidPassword: state.password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          (confirmPassword.compareTo(state.password) == 0),
    ));
  }

  Future<void> _onSubmitted(
      RegisterSubmited event, Emitter<RegisterState> emit) async {
    if (state.isValidEmail && state.isValidUsername && state.isValidPassword) {
      try {
        bool isSuccess = await _authenticationRepository.register(
          email: state.email,
          username: state.username,
          password: state.password,
        );

        emit(state.copyWith(
          status: isSuccess ? RegisterStatus.success : RegisterStatus.failure,
        ));
      } catch (_) {
        emit(state.copyWith(status: RegisterStatus.failure));
      }
    }
  }
}
