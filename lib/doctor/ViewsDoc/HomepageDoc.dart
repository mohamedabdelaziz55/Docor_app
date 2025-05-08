import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:doctor_app/doctor/ViewsDoc/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../Screens/Login-Signup/shedule_screen.dart';
import '../Login-Signup/Profile_screen.dart';
import '../Widgets/TabbarPages/message_tab_all.dart';
import 'articles_doc_screen.dart';

class HomepageDoc extends StatefulWidget {
  static String id = "/HomepageDoc";

  @override
  State<HomepageDoc> createState() => _HomepageDocState();
}

class _HomepageDocState extends State<HomepageDoc> {
  RxInt page = 0.obs;

  List<IconData> icons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.question,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.clipboardCheck,
    FontAwesomeIcons.user,
  ];

  List<Widget> pages = [
    ArticlesDocScreen(),
    QuestionsScreenDoc(),
    message_taball(),
    ScheduleScreen(),
    Profile_Doc_screen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => pages[page.value]),
      bottomNavigationBar: Obx(
            () => AnimatedBottomNavigationBar(
          icons: icons,
          iconSize: 20,
          activeIndex: page.value,
          height: 80,
          splashSpeedInMilliseconds: 300,
          gapLocation: GapLocation.none,
          activeColor: const Color.fromARGB(255, 0, 190, 165),
          inactiveColor: const Color.fromARGB(255, 223, 219, 219),
          onTap: (int tappedIndex) {
            page.value = tappedIndex;
          },
        ),
      ),
    );
  }
}
