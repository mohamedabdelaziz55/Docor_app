import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnBoardingController extends GetxController {
  var pageIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: pageIndex.value);
    super.onInit();
  }

  void goToPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    pageIndex.value = index;
  }

  Future<void> completeOnBoarding() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('onBoardingCompleted', true);
  }
}
