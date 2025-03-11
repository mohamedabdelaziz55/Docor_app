import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../models/models_patient/model_doctors.dart';

class list_doctor1 extends StatelessWidget {
  const list_doctor1({required this.modelsDoctor, this.onPressed});

  final ModelsDoctors modelsDoctor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 100,
          // width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 240, 236, 236),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(modelsDoctor.image),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        modelsDoctor.name,
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        modelsDoctor.supText,
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.015,
                            width: MediaQuery.of(context).size.width * 0.08,
                            color: Color.fromARGB(255, 240, 236, 236),
                            child: Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height *
                                      0.015,
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/icons/Star.png",
                                      ),
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${modelsDoctor.star}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Color.fromARGB(255, 4, 179, 120),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.015,
                            width: MediaQuery.of(context).size.width * 0.03,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/icons/Location.png"),
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                          Text(
                            modelsDoctor.address,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
