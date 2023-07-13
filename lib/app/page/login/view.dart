import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:youapp_test/app/page/login/bloc/login_bloc.dart';
import 'package:youapp_test/app/page/register/view.dart';
import 'package:youapp_test/app/utils/constants.dart';
import 'package:youapp_test/app/widgets/bg_widget/view.dart';
import 'package:youapp_test/app/widgets/default_btn_widget/view.dart';
import 'package:youapp_test/app/widgets/input_widget/view.dart';
import 'package:youapp_test/data/repositories/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
          body: BlocProvider(
            create: (context) => LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            ),
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.failure) {
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                      msg: "Login failed, please try again.");
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsets.only(top: 60, left: 41, bottom: 25),
                      child: Text(
                        'Login',
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
                          child: BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (previous, current) =>
                                previous.username != current.username,
                            builder: (context, state) => InputWidget(
                              readonly: state.isLoading,
                              onChanged: (value) => context
                                  .read<LoginBloc>()
                                  .add(LoginUsernameChanged(value)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 23, top: 15, right: 23),
                          child: BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (previous, current) =>
                                previous.password != current.password,
                            builder: (context, state) => InputWidget(
                              hintText: 'Enter Password',
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              readonly: state.isLoading,
                              onChanged: (value) => context
                                  .read<LoginBloc>()
                                  .add(LoginPasswordChanged(value)),
                              errorText: state.status == LoginStatus.failure
                                  ? 'Login failed, check your Username/Password.'
                                  : null,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 23, top: 25, right: 23),
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) => DefaultButtonWidget(
                              onPressed: state.isUsernameValid &&
                                      state.isPasswordValid &&
                                      !state.isLoading
                                  ? () => context
                                      .read<LoginBloc>()
                                      .add(const LoginSubmitted())
                                  : null,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 52),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'No account? ',
                                  style: myTextStyle(),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => Get.to(const RegisterPage()),
                                  text: 'Register here',
                                  style: myTextStyle(
                                    color: Colors.yellow[800],
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.yellow[800],
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
          ),
        ),
      ],
    );
  }
}
