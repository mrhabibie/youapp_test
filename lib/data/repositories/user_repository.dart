import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_test/data/utils/constants.dart';
import 'package:youapp_test/domain/entities/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(Constants.userKey);
    _user = User.fromRawJson(jsonString ?? "");

    return _user;
  }
}
