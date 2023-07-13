import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_test/app/utils/constants.dart';
import 'package:youapp_test/app/widgets/input_widget/bloc/obscure_cubit.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    this.hintText,
    this.errorText,
    this.readonly,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
    this.textInputAction,
  }) : super(key: key);

  final String? hintText;
  final String? errorText;
  final bool? readonly;
  final void Function(String value)? onChanged;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObscureCubit(),
      child: BlocBuilder<ObscureCubit, bool>(
        builder: (context, state) {
          return TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              fillColor: Colors.white.withOpacity(0.05),
              focusColor: Colors.white.withOpacity(0.05),
              hoverColor: Colors.white.withOpacity(0.05),
              filled: true,
              hintText: hintText ?? 'Enter Username/Email',
              hintStyle: myTextStyle(color: Colors.white.withOpacity(0.4)),
              errorText: errorText,
              errorStyle: myTextStyle(color: Colors.red),
              suffixIcon: obscureText != null && obscureText!
                  ? IconButton(
                      onPressed: () => context.read<ObscureCubit>().toggle(),
                      icon: Icon(
                        state
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: Colors.yellow[800],
                      ),
                    )
                  : null,
            ),
            readOnly: readonly ?? false,
            onChanged: onChanged,
            style: myTextStyle(decoration: TextDecoration.none),
            textAlign: TextAlign.left,
            keyboardType: keyboardType ?? TextInputType.text,
            obscureText: obscureText != null && obscureText! ? state : false,
            textInputAction: textInputAction ?? TextInputAction.next,
          );
        },
      ),
    );
  }
}
