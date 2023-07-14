import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_test/data/utils/constants.dart';
import 'package:youapp_test/domain/entities/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _db = FirebaseFirestore.instance;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString(Constants.userKey);

    print('==> userAuthenticated: $jsonUser');

    if (jsonUser != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }

    yield* _controller.stream;
  }

  Future<bool> logIn(
      {required String username, required String password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      QuerySnapshot<Map<String, dynamic>> findByEmail = await _db
          .collection("users")
          .where("email", isEqualTo: username)
          .limit(1)
          .get();
      if (findByEmail.docs.isEmpty) {
        QuerySnapshot<Map<String, dynamic>> findByUsername = await _db
            .collection("users")
            .where("username", isEqualTo: username)
            .limit(1)
            .get();
        if (findByUsername.docs.isEmpty) {
          return false;
        } else {
          if (findByUsername.docs.first.data()["password"] == password) {
            prefs.setString(Constants.userKey,
                User.fromJson(findByUsername.docs.first.data()).toRawJson());

            _controller.add(AuthenticationStatus.authenticated);
          }

          return findByUsername.docs.first.data()["password"] == password;
        }
      } else {
        if (findByEmail.docs.first.data()["password"] == password) {
          final User user = User.fromJson(findByEmail.docs.first.data());

          prefs.setString(Constants.userKey, user.toRawJson());

          _controller.add(AuthenticationStatus.authenticated);
        }

        return findByEmail.docs.first.data()["password"] == password;
      }
    } catch (e) {
      print('==> login error (e): ${e.toString()}');

      return false;
    }
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

  void logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Constants.userKey);

    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
