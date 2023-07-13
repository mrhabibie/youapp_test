import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:youapp_test/data/repositories/authentication_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState(username: '', password: '')) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    final username = event.username;
    emit(state.copyWith(
        username: username,
        isUsernameValid: username.isNotEmpty && username.length >= 3));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = event.password;
    emit(state.copyWith(
        password: password,
        isPasswordValid: password.isNotEmpty && password.length >= 6));
  }

  Future<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.isUsernameValid && state.isPasswordValid) {
      emit(state.copyWith(isLoading: true));

      try {
        bool isSuccess = await _authenticationRepository.logIn(
          username: state.username,
          password: state.password,
        );

        emit(state.copyWith(
          isLoading: false,
          status: isSuccess ? LoginStatus.success : LoginStatus.failure,
        ));
      } catch (_) {
        emit(state.copyWith(isLoading: false, status: LoginStatus.failure));
      }
    }
  }
}
