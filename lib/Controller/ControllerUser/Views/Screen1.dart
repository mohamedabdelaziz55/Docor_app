import 'dart:async';
import 'package:get/get.dart';

import '../../../view/UserView/On_Board/on_boarding.dart';

class Screen1Controller extends GetxController {
  void navigateToOnBoarding() {
    Timer(Duration(seconds: 3), () {
      Get.offAll(() => OnBoarding());
    });
  }
}

