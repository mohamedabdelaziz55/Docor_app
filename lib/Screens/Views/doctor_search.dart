import 'package:doctor_app/Screens/Views/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../date/dummy_doctor.dart';
import '../Widgets/list_doctor1.dart';
import 'doctor_details_screen.dart';

class doctor_search extends StatelessWidget {
  doctor_search({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_DoctorSearchController>(
      init: _DoctorSearchController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Get.off(() => Homepage(), transition: Transition.fade);
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
              physics: const BouncingScrollPhysics(),
              itemCount: dummyDoctorList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                          () => DoctorDetails(doctor: dummyDoctorList[index]),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: DoctorList(modelsDoctor: dummyDoctorList[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _DoctorSearchController extends GetxController {}
