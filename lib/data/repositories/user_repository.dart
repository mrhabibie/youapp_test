import 'package:youapp_test/domain/entities/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(
        email: 'test@gmail.com',
        username: 'mrhabibie',
        password: '123',
        name: 'Habibie',
        height: 156,
        weight: 45,
        birthday: DateTime(2023, 08, 11),
        gender: 'male',
        horoscope: 'Leo',
        zodiac: 'Peler',
      ),
    );
  }
}
