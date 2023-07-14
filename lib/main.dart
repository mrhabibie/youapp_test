import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youapp_test/app/page/login/view.dart';
import 'package:youapp_test/app/page/profile/view.dart';
import 'package:youapp_test/app/page/splash/bloc/authentication_bloc.dart';
import 'package:youapp_test/app/page/splash/view.dart';
import 'package:youapp_test/data/repositories/authentication_repository.dart';
import 'package:youapp_test/data/repositories/user_repository.dart';
import 'package:youapp_test/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'YouApp Test by Habibie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow[800]!),
        useMaterial3: true,
      ),
      builder: (context, child) =>
          BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              Get.off(() => const ProfilePage());
            case AuthenticationStatus.unauthenticated:
              Get.off(() => const LoginPage());
            case AuthenticationStatus.unknown:
              break;
          }
        },
        child: child,
      ),
      onGenerateRoute: (settings) => SplashPage.route(),
    );
  }
}
