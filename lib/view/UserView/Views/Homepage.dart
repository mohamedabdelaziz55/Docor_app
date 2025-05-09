import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Login-Signup/Profile_screen.dart';
import '../Login-Signup/shedule_screen.dart';
import '../Widgets/TabbarPages/message_tab_all.dart';
import 'Dashboard_screen.dart';

class Homepage extends StatelessWidget {
  static String id = "/Homepage";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_HomepageController>(
      init: _HomepageController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: controller.pages[controller.page],
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: controller.icons,
            iconSize: 20,
            activeIndex: controller.page,
            height: 80,
            splashSpeedInMilliseconds: 300,
            gapLocation: GapLocation.none,
            activeColor: const Color.fromARGB(255, 0, 190, 165),
            inactiveColor: const Color.fromARGB(255, 223, 219, 219),
            onTap: (int tappedIndex) {
              controller.changePage(tappedIndex);
            },
          ),
        );
      },
    );
  }
}

class _HomepageController extends GetxController {
  int page = 0;

  List<IconData> icons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.clipboardCheck,
    FontAwesomeIcons.user,
  ];

  List<Widget> pages = [
    Dashboard(),
    MessageTabAll(),
    ScheduleScreen(),
    Profile_screen(),
  ];

  void changePage(int tappedIndex) {
    page = tappedIndex;
    update();
  }
}
