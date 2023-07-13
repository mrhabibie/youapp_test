import 'package:flutter/material.dart';
import 'package:youapp_test/app/utils/constants.dart';
import 'package:youapp_test/app/widgets/bg_widget/view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const BackgroundWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          body: Center(
            child: Text(
              'Selamat datang!',
              style: myTextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
