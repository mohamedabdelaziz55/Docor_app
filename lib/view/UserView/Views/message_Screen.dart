import 'package:doctor_app/view/UserView/Views/shedule_tab2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../DoctorView/ViewsDoc/shedule_tab1.dart';
import '../Widgets/TabbarPages/message_tab_all.dart';



class MessageScreenController extends GetxController {
  RxInt selectedTab = 0.obs;

  // Change the selected tab
  void changeTab(int index) {
    selectedTab.value = index;
  }
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final MessageScreenController controller = Get.put(MessageScreenController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    // Listen for changes in the selectedTab and update the TabController
    controller.selectedTab.listen((index) {
      tabController.animateTo(index); // Animate to the selected tab
    });
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
          "Top Doctors",
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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 00),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 235, 235, 235)),
                          color: const Color.fromARGB(255, 241, 241, 241),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: TabBar(
                                indicator: BoxDecoration(
                                  color: const Color.fromARGB(255, 5, 185, 155),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                indicatorColor: const Color.fromARGB(255, 241, 241, 241),
                                unselectedLabelColor: const Color.fromARGB(255, 32, 32, 32),
                                labelColor: const Color.fromARGB(255, 255, 255, 255),
                                controller: tabController,
                                tabs: const [
                                  Tab(
                                    text: "Upcoming",
                                  ),
                                  Tab(
                                    text: "Completed",
                                  ),
                                  Tab(
                                    text: "Cancel",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TabBarView(controller: tabController, children:  [
                      MessageTabAll(),
                      ScheduleTab1(),
                      ScheduleTab2(),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
