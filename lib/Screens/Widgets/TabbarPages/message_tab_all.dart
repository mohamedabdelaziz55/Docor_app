import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Views/chat_screen.dart';
import '../message_all_widget.dart';

class message_tab_all extends StatefulWidget {
  const message_tab_all({Key? key}) : super(key: key);

  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<message_tab_all>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Shedule",
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 18.sp),
        ),
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/icons/bell.png"),
              )),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                    child: ChatScreen(
                      currentUserId: 1, // ID المستخدم الحالي (ممكن تجيبه من SharedPreferences)
                      receiverId: 2,    // ID الدكتور اللي هتكلمه
                      receiverName: "Dr. Marcus Horizon",
                    ),));
            },
            child: message_all_widget(
              image: "assets/icons/male-doctor.png",
              mainText: "Dr. Marcus Horizon",
              subText: "I don,t have any fever, but headchace...",
              time: "10.24",
              messageCount: "2",
            ),
          ),
          message_all_widget(
            image: "assets/icons/docto3.png",
            mainText: "Dr. Alysa Hana",
            subText: "Hello, How can i help you?",
            time: "10.24",
            messageCount: "1",
          ),
          message_all_widget(
            image: "assets/icons/doctor2.png",
            mainText: "Dr. Maria Elena",
            subText: "Do you have fever?",
            time: "10.24",
            messageCount: "3",
          ),
        ]),
      ),
    );
  }
}
