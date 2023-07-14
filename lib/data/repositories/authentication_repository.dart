import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youapp_test/domain/entities/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _db = FirebaseFirestore.instance;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<bool> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final docRef = _db.collection("users").doc(username);
      docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return true;
      }, onError: (e) {
        _controller.add(AuthenticationStatus.unauthenticated);

        return false;
      });
    } catch (e) {
      print('==> firebase error: ${e.toString()}');
      _controller.add(AuthenticationStatus.unauthenticated);

      return false;
    }

    return false;
  }

  Future<bool> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      bool isSuccess = false;

      final userData =
          User(email: email, username: username, password: password);
      isSuccess =
          await _db.collection("users").add(userData.toJson()).then((value) {
        return true;
      }, onError: (e) {
        print('==> register error: ${e.toString()}');

        return false;
      });

      return isSuccess;
    } catch (e) {
      print('==> register error (e): ${e.toString()}');
      return false;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
