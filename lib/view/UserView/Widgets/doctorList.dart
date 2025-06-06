import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class DoctorListController extends GetxController {
  // Controller logic (if needed in the future) can be added here
}

class DoctorList extends StatelessWidget {
  final String image;
  final String mainText;
  final String subText;
  final String numRating;
  final String distance;

  DoctorList(
      {required this.distance,
        required this.image,
        required this.mainText,
        required this.numRating,
        required this.subText});

  @override
  Widget build(BuildContext context) {
    final DoctorListController controller = Get.put(DoctorListController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1400,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              // Doctor image container
              Container(
                height: MediaQuery.of(context).size.height * 0.1200,
                width: MediaQuery.of(context).size.width * 0.2400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(image),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.1200,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mainText,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subText,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01500,
                          width: MediaQuery.of(context).size.width * 0.08,
                          color: Color.fromARGB(255, 240, 236, 236),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.01500,
                                width: MediaQuery.of(context).size.width * 0.03,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/icons/Star.png",
                                    ),
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                              Text(
                                numRating,
                                style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  color: Color.fromARGB(255, 4, 179, 120),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01500,
                          width: MediaQuery.of(context).size.width * 0.03,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/icons/Location.png",
                              ),
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          distance,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Color.fromARGB(255, 133, 133, 133),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
