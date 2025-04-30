import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login-Signup/login_signup.dart';
import 'on_board1.dart';
import 'on_board2.dart';
import 'on_board3.dart';
import 'on_board4.dart';

class on_boarding extends StatefulWidget {
  const on_boarding({super.key});
  static const String id = 'on_boarding';

  @override
  State<on_boarding> createState() => _on_boardingState();
}

class _on_boardingState extends State<on_boarding> {
  PageController _controller = PageController();
  bool onLastpage = false;

  // حفظ إنه خلص الـ onboarding
  Future<void> completeOnBoarding() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('onBoardingCompleted', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastpage = (index == 3); // عشان عندنا 4 صفحات
              });
            },
            children: const [
              on_board1(),
              on_board2(),
              on_board3(),
              on_board4(),
            ],
          ),
          Container(
            alignment: const Alignment(-0.6, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(3); // نروح لآخر صفحة
                  },
                  child: Text(
                    "Skip",
                    style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 4, // عندنا 4 شاشات
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
                onLastpage
                    ? GestureDetector(
                  onTap: () async {
                    await completeOnBoarding(); // نحفظ انه خلص
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: login_signup(),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
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
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.04,
                            child: Image.asset("assets/icons/check.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
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
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.06,
                            child: Image.asset("assets/icons/arrow.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
