import 'package:flutter/material.dart';
import 'package:youapp_test/app/widgets/bg_widget/view.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (context) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[
        BackgroundWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
