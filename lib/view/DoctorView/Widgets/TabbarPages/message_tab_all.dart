import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../UserView/Views/chat_screen.dart';
import '../message_all_widget.dart';

class message_taball extends StatefulWidget {
  const message_taball({Key? key}) : super(key: key);

  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<message_taball>
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
                ),
              ),
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
                Get.to(
                      () => ChatScreen(
                    currentUserId: 1,
                    receiverId: 2,
                    receiverName: "Mohamed Elsafty",
                  ),
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 300),
                );
              },
              child: MessageAllWidget(
                image: "assets/images/persona.jpg",
                mainText: "Mohamed Elsafty",
                subText: "I don't have any fever, but headache...",
                time: "10.24",
                messageCount: "2",
              ),
            ),
            MessageAllWidget(
              image: "assets/images/personp.jpg",


              mainText: "Ahmed Mohamed",
              subText: "Hello, How can I help you?",
              time: "10.24",
              messageCount: "1",
            ),

          ],
        ),
      ),
    );
  }
}
