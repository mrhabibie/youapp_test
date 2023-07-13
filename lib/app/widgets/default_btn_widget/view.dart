import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_test/app/utils/constants.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({Key? key, this.label, this.onPressed})
      : super(key: key);

  final String? label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xff62CDCB), Color(0xff4599DB)]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.01),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.black.withOpacity(0.5),
          disabledBackgroundColor: Colors.black.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label ?? 'Login',
          style: myTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
