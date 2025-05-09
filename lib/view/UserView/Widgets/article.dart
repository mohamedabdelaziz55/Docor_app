import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ArticleController extends GetxController {
  // Here you can manage any variables or actions needed for the screen
}

class Article extends StatelessWidget {
  final String mainText;
  final String dateText;
  final String duration;
  final String image;

  Article({
    required this.mainText,
    required this.dateText,
    required this.duration,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final ArticleController controller = Get.put(ArticleController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.085,
        width: MediaQuery.of(context).size.width * 0.8500,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 231, 231, 231)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const SizedBox(
            width: 5,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.1200,
            child: Image.asset(image),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                mainText,
                style: GoogleFonts.poppins(
                    fontSize: 13.sp, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      dateText,
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      duration,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 136, 102),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(
            width: 25,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.09,
            child: Image.asset(
              "assets/icons/Bookmark.png",
              filterQuality: FilterQuality.high,
            ),
          ),
        ]),
      ),
    );
  }
}
