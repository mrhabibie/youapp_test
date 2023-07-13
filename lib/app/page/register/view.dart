import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_test/app/utils/constants.dart';
import 'package:youapp_test/app/widgets/bg_widget/view.dart';
import 'package:youapp_test/app/widgets/default_btn_widget/view.dart';
import 'package:youapp_test/app/widgets/input_widget/view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 60, left: 41, bottom: 25),
                  child: Text(
                    'Register',
                    style: myTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: const InputWidget(
                        hintText: 'Enter Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 23, vertical: 11),
                      child: const InputWidget(hintText: 'Create Username'),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: const InputWidget(
                        hintText: 'Create Password',
                        obscureText: true,
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 23, top: 11, right: 23),
                      child: const InputWidget(
                        hintText: 'Confirm Password',
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 23, top: 25, right: 23),
                      child: const DefaultButtonWidget(label: 'Register'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 52),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Have an account? ',
                              style: myTextStyle(),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: 'Login here',
                              style: myTextStyle(
                                color: Colors.yellow[800],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
