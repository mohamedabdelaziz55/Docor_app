import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../doctor/ViewsDoc/appointment.dart';
import '../../doctor/Widgets/date_select.dart';
import '../../doctor/Widgets/doctorList.dart';
import '../../doctor/Widgets/time_select.dart';
import '../../models/models_patient/model_doctors.dart';


class DoctorDetails extends StatelessWidget {
  final ModelsDoctors doctor;

  const DoctorDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_DoctorDetailsController>(
      init: _DoctorDetailsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/back1.png"),
                  ),
                ),
              ),
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
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/more.png"),
                    ),
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  const SizedBox(height: 5),
                  DoctorList(
                    distance: "800m away",
                    image: doctor.image,
                    maintext: doctor.name,
                    numRating: doctor.star.toString(),
                    subtext: doctor.supText,
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: controller.toggleTextVisibility,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About",
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.showExtendedText
                                ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod elipss this is just a dummy text with some free lines do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam consectetur adipiscing elit. Sed euismod ..."
                                : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod elipss this is just a dummy text with some free ... ",
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 37, 37, 37),
                              fontSize: 14.sp,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.showExtendedText ? "Read less" : "Read more",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 1, 128, 111),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.width * 3,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          DateSelect(date: "21", maintext: "Mon"),
                          DateSelect(date: "22", maintext: "Tue"),
                          DateSelect(date: "23", maintext: "Wed"),
                          DateSelect(date: "24", maintext: "Thu"),
                          DateSelect(date: "25", maintext: "Fri"),
                          DateSelect(date: "26", maintext: "Sat"),
                          DateSelect(date: "27", maintext: "Sun"),
                          DateSelect(date: "28", maintext: "Mon"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(color: Colors.black12, thickness: 1),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2400,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2500,
                          width: MediaQuery.of(context).size.width * 0.2900,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              TimeSelect(mainText: "09:00 AM"),
                              TimeSelect(mainText: "01:00 AM"),
                              TimeSelect(mainText: "04:00 AM"),
                              TimeSelect(mainText: "07:00 AM"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2500,
                          width: MediaQuery.of(context).size.width * 0.2500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              TimeSelect(mainText: "10:00 PM"),
                              TimeSelect(mainText: "02:00 PM"),
                              TimeSelect(mainText: "07:00 PM"),
                              TimeSelect(mainText: "09:00 PM"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2500,
                          width: MediaQuery.of(context).size.width * 0.2500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              TimeSelect(mainText: "11:00 AM"),
                              TimeSelect(mainText: "03:00 PM"),
                              TimeSelect(mainText: "08:00 PM"),
                              TimeSelect(mainText: "10:00 AM"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.1300,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 247, 247, 247),
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage("assets/icons/Chat.png"),
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Appointment( modelsDoctors: doctor,),
                            ),
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.6300,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 2, 179, 149),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Book Appointment",
                                style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DoctorDetailsController extends GetxController {
  bool showExtendedText = false;

  void toggleTextVisibility() {
    showExtendedText = !showExtendedText;
    update();
  }
}
