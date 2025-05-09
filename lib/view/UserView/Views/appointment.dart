import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../../models/models_patient/model_doctors.dart';
import '../Widgets/doctorList.dart';
import 'doctor_details_screen.dart';

class AppointmentController extends GetxController {
  Rx<ModelsDoctors> doctor = ModelsDoctors(
    about: 'About the doctor...',
    supText: 'Specialization text...',
    name: 'Doctor Name',
    image: 'path_to_image',
    id: 123,
    address: 'Doctor\'s address',
    star: 4.5,
  ).obs; // Rx variable for doctor data
  RxString appointmentDate = 'Wednesday, Jun 23, 2021 | 10:00 AM'.obs; // Rx variable for date
  RxString reason = 'Chest pain'.obs; // Rx variable for reason
  RxDouble consultationFee = 60.0.obs;
  RxDouble adminFee = 1.0.obs;
  RxDouble totalFee = 61.0.obs;
  RxString paymentMethod = 'Visa'.obs;
}

class Appointment extends StatelessWidget {
  final ModelsDoctors modlesDoctors;

  const Appointment({Key? key, required this.modlesDoctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize GetX controller
    final controller = Get.put(AppointmentController());
    controller.doctor.value = modlesDoctors; // Set doctor data
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: DoctorDetails(doctor: modlesDoctors),
              ),
            );
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
                image: DecorationImage(image: AssetImage("lib/icons/more.png")),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                const SizedBox(height: 5),
                DoctorList(
                  distance: "800m away",
                  image: controller.doctor.value.image,
                  mainText: controller.doctor.value.name,
                  numRating: '${controller.doctor.value.star}',
                  subText: controller.doctor.value.supText,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add logic to change date if needed
                        },
                        child: Text(
                          "Change",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            color: const Color.fromARGB(137, 56, 56, 56),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.1300,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 247, 247, 247),
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage("assets/icons/callender.png"),
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Obx(() => Text(
                          controller.appointmentDate.value,
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reason",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add logic to change reason if needed
                        },
                        child: Text(
                          "Change",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            color: const Color.fromARGB(137, 56, 56, 56),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: Colors.black12),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.1300,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 247, 247, 247),
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage("assets/icons/pencil.png"),
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Obx(() => Text(
                        controller.reason.value,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: Colors.black12),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Payment Details",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Consultation",
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Obx(() => Text(
                        "\$${controller.consultationFee.value}",
                        style: GoogleFonts.poppins(fontSize: 16.sp),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Admin Fee",
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Obx(() => Text(
                        "\$${controller.adminFee.value}",
                        style: GoogleFonts.poppins(fontSize: 16.sp),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Additional Discount",
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Obx(() => Text(
                        "-",
                        style: GoogleFonts.poppins(fontSize: 16.sp),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Obx(() => Text(
                        "\$${controller.totalFee.value}",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Color.fromARGB(255, 4, 92, 58),
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: Colors.black12),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("Payment Method")],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text(
                          controller.paymentMethod.value,
                          style: GoogleFonts.inter(
                            fontStyle: FontStyle.italic,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 38, 39, 117),
                          ),
                        )),
                        Text(
                          "Change",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            color: const Color.fromARGB(137, 56, 56, 56),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.2100,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                  color: const Color.fromARGB(137, 56, 56, 56),
                                ),
                              ),
                              SizedBox(height: 5),
                              Obx(() => Text(
                                "\$${controller.totalFee.value}",
                                style: GoogleFonts.inter(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0,
                                  color: Colors.black87,
                                ),
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 15), backgroundColor: const Color.fromARGB(255, 4, 92, 58),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Text(
                              'Book Appointment',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
