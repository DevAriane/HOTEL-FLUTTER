import 'dart:async';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var opacite = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _declencherAnimation();
    _demarrerChronometre();
  }

  void _declencherAnimation() {
    Future.delayed(const Duration(milliseconds: 50), () {
      opacite.value = 1.0;
    });
  }

  void _demarrerChronometre() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.offNamed('/second');
    });
  }
}
