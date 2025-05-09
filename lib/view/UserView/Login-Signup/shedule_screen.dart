import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../Views/shedule_tab1.dart';
import '../Views/shedule_tab2.dart';

class ScheduleScreen extends StatefulWidget {
  static String id = "schedule_screen";

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final Rx<int> selectedTabIndex = Rx<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Task",
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20.sp),
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
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 235, 235, 235)),
                  color: Color.fromARGB(255, 241, 241, 241),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Color.fromARGB(255, 5, 185, 155),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    unselectedLabelColor: Color.fromARGB(255, 32, 32, 32),
                    labelColor: Colors.white,
                    tabs: const [
                      Tab(text: "Upcoming"),
                      Tab(text: "Completed"),
                      Tab(text: "Cancel"),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  SchedulgeTabDoc1(),
                  ScheduleTab2(),
                  ScheduleTab2(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
