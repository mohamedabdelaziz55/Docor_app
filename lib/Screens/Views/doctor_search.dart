import 'package:doctor_app/Screens/Views/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../date/dummy_doctor.dart';
import '../Widgets/list_doctor1.dart';
import 'doctor_details_screen.dart';

class doctor_search extends StatelessWidget {
  doctor_search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: Homepage()));
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Top Doctors",
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.more_horiz),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: dummyDoctorList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: DoctorDetails(doctor: dummyDoctorList[index]),
                  ),
                );
              },
              child: list_doctor1(modelsDoctor: dummyDoctorList[index]),
            );
          },
        ),
      ),
    );
  }
}