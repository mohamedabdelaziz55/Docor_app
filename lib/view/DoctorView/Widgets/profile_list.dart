import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class ProfileList extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final void Function()? onTap;

  ProfileList({
    required this.image,
    required this.title,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.1500,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 247, 250, 247),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(image),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.5800,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.1100,
                    decoration: const BoxDecoration(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
