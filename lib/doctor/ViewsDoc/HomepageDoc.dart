import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:doctor_app/doctor/ViewsDoc/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Screens/Login-Signup/Profile_screen.dart';
import '../../Screens/Login-Signup/shedule_screen.dart';
import '../../Screens/Widgets/TabbarPages/message_tab_all.dart';
import 'articles_doc_screen.dart';


class HomepageDoc extends StatefulWidget {
  static String id="HomepageDoc";

  @override
  State<HomepageDoc> createState() => _HomepageDocState();
}

class _HomepageDocState extends State<HomepageDoc> {
  List<IconData> icons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.question,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.clipboardCheck,
    FontAwesomeIcons.user,
  ];

  int page = 0;

  List<Widget> pages = [
    ArticlesDocScreen(), // You can replace this with your actual pages
    QuestionsScreenDoc(),
    message_tab_all(),
    shedule_screen(),
    Profile_screen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[page],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: icons,
        iconSize: 20,
        activeIndex: page,
        height: 80,
        splashSpeedInMilliseconds: 300,
        gapLocation: GapLocation.none,
        activeColor: const Color.fromARGB(255, 0, 190, 165),
        inactiveColor: const Color.fromARGB(255, 223, 219, 219),
        onTap: (int tappedIndex) {
          setState(() {
            page = tappedIndex;
          });
        },
      ),
    );
  }
}
