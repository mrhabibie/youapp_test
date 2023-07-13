import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 4,
          colors: <Color>[
            Color(0xFF1F4247),
            Color(0xFF0D1C22),
            Color(0xFF09141A),
          ],
        ),
      ),
    );
  }
}
