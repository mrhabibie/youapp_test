import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

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

    /*await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );*/
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
