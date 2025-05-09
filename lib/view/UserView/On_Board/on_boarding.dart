import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/ControllerUser/On_Board/on_boarding.dart';
import '../Login-Signup/login_signup.dart';
import 'on_board1.dart';
import 'on_board2.dart';
import 'on_board3.dart';
import 'on_board4.dart';


class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
  static const String id = '/OnBoarding';

  @override
  Widget build(BuildContext context) {
    final OnBoardingController controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              controller.pageIndex.value = index;
            },
            controller: controller.pageController,
            children: const [
              OnBoard1(),
              OnBoard2(),
              OnBoard3(),
              OnBoard4(),
            ],
          ),
          Container(
            alignment: const Alignment(-0.6, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.goToPage(3);
                  },
                  child: Text(
                    "Skip",
                    style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller.pageController,
                  count: 4,
                  effect: const SlideEffect(
                    spacing: 4.0,
                    radius: 4.0,
                    dotWidth: 14.0,
                    dotHeight: 7.0,
                    strokeWidth: 1.5,
                    dotColor: Color.fromARGB(255, 170, 255, 237),
                    activeDotColor: Color.fromARGB(255, 3, 190, 150),
                  ),
                ),
                Obx(() => controller.pageIndex.value == 3
                    ? GestureDetector(
                  onTap: () async {
                    await controller.completeOnBoarding();
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: login_signup(),
                      ),
                    );
                  },
                  child: Container(
                    height:
                    MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 3, 190, 150),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Done ",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height *
                                0.04,
                            width: MediaQuery.of(context).size.width *
                                0.04,
                            child:
                            Image.asset("assets/icons/check.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    controller.goToPage(
                        controller.pageIndex.value + 1);
                  },
                  child: Container(
                    height:
                    MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 3, 190, 150),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next ",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height *
                                0.06,
                            width: MediaQuery.of(context).size.width *
                                0.06,
                            child:
                            Image.asset("assets/icons/arrow.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
