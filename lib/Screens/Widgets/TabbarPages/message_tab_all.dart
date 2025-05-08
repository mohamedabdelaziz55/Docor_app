import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Views/chat_screen.dart';
import '../message_all_widget.dart';

class MessageTabAllController extends GetxController {
  RxInt currentTabIndex = 0.obs;

  void changeTabIndex(int index) {
    currentTabIndex.value = index;
  }
}

class MessageTabAll extends StatelessWidget {
  const MessageTabAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MessageTabAllController controller = Get.put(MessageTabAllController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Schedule",
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
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: ChatScreen(
                      currentUserId: 1, // Current user ID (can be fetched from SharedPreferences)
                      receiverId: 2,    // Doctor's ID to chat with
                      receiverName: "Dr. Marcus Horizon",
                    ),
                  ),
                );
              },
              child: MessageAllWidget(
                image: "assets/icons/male-doctor.png",
                mainText: "Dr. Marcus Horizon",
                subText: "I don't have any fever, but headache...",
                time: "10:24",
                messageCount: "2",
              ),
            ),
            MessageAllWidget(
              image: "assets/icons/docto3.png",
              mainText: "Dr. Alysa Hana",
              subText: "Hello, How can I help you?",
              time: "10:24",
              messageCount: "1",
            ),
            MessageAllWidget(
              image: "assets/icons/doctor2.png",
              mainText: "Dr. Maria Elena",
              subText: "Do you have fever?",
              time: "10:24",
              messageCount: "3",
            ),
          ],
        ),
      ),
    );
  }
}
