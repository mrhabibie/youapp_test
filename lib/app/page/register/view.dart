import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:youapp_test/app/page/register/bloc/register_bloc.dart';
import 'package:youapp_test/app/utils/constants.dart';
import 'package:youapp_test/app/widgets/bg_widget/view.dart';
import 'package:youapp_test/app/widgets/default_btn_widget/view.dart';
import 'package:youapp_test/app/widgets/input_widget/view.dart';
import 'package:youapp_test/data/repositories/authentication_repository.dart';

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
          body: BlocProvider(
            create: (context) => RegisterBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            ),
            child: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state.status == RegisterStatus.success) {
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                      msg: 'Register success, you can login now.');
                } else if (state.status == RegisterStatus.failure) {
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                      msg: 'Register failed, please try again.');
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
                          child: BlocBuilder<RegisterBloc, RegisterState>(
                            buildWhen: (previous, current) =>
                                previous.email != current.email,
                            builder: (context, state) => InputWidget(
                              hintText: 'Enter Email',
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => context
                                  .read<RegisterBloc>()
                                  .add(RegisterEmailChanged(value)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 23, vertical: 11),
                          child: BlocBuilder<RegisterBloc, RegisterState>(
                            buildWhen: (previous, current) =>
                                previous.username != current.username,
                            builder: (context, state) => InputWidget(
                              hintText: 'Create Username',
                              onChanged: (value) => context
                                  .read<RegisterBloc>()
                                  .add(RegisterUsernameChanged(value)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 23),
                          child: BlocBuilder<RegisterBloc, RegisterState>(
                            buildWhen: (previous, current) =>
                                previous.password != current.password,
                            builder: (context, state) => InputWidget(
                              hintText: 'Create Password',
                              obscureText: true,
                              onChanged: (value) => context
                                  .read<RegisterBloc>()
                                  .add(RegisterPasswordChanged(value)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 23, top: 11, right: 23),
                          child: BlocBuilder<RegisterBloc, RegisterState>(
                            buildWhen: (previous, current) =>
                                previous.confirmPassword !=
                                current.confirmPassword,
                            builder: (context, state) => InputWidget(
                              hintText: 'Confirm Password',
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) => context
                                  .read<RegisterBloc>()
                                  .add(RegisterConfirmPasswordChanged(value)),
                              errorText: !state.isValidPassword
                                  ? "Password doesn't match."
                                  : null,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 23, top: 25, right: 23),
                          child: BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) => DefaultButtonWidget(
                              label: 'Register',
                              onPressed: state.isValidEmail &&
                                      state.isValidUsername &&
                                      state.isValidPassword
                                  ? () => context
                                      .read<RegisterBloc>()
                                      .add(const RegisterSubmited())
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
