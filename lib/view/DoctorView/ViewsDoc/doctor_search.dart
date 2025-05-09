import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../../date/dummy_doctor.dart';
import '../../UserView/Views/Homepage.dart';
import '../../UserView/Views/doctor_details_screen.dart';
import '../Widgets/list_doctor1.dart';

class DoctorSearchController extends GetxController {
  var searchQuery = ''.obs;
}

class DoctorSearch extends StatelessWidget {
  DoctorSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorSearchController controller = Get.put(DoctorSearchController());

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
              child: ListDoctor1(modelsDoctor: dummyDoctorList[index]),
            );
          },
        ),
      ),
    );
  }
}
