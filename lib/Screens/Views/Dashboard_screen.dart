import 'package:doctor_app/Screens/Views/questions_screen.dart';
import 'package:doctor_app/date/dummy_doctor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Widgets/article.dart';
import '../Widgets/banner.dart';
import '../Widgets/listIcons.dart';
import '../Widgets/list_doctor2.dart';
import 'articlePage.dart';
import 'doctor_details_screen.dart';
import 'doctor_search.dart';
import 'find_doctor.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset(
                "assets/icons/bell.png",
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
        title: Column(
          children: [
            SizedBox(height: 50),
            Text(
              "Find your desire\nhealth solution",
              style: GoogleFonts.inter(
                color: Color.fromARGB(255, 51, 47, 47),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        toolbarHeight: 130,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(),
                child: SearchTextField(ontap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: find_doctor(),
                    ),
                  );
                }, text: "Search doctor, drugs, articles...",),
              ),
            ),
            SizedBox(height: 20),
            // Body Start from here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                listIcons(Icon: "assets/icons/Doctor.png", text: "Doctor"),
                listIcons(Icon: "assets/icons/appoint.png", text: "Articles"),
                listIcons(
                  Icon: "assets/icons/communication.png",
                  text: "Questions",
                  ontap: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: QuestionsScreen(),
                      ),
                    );
                  },
                ),
                listIcons(Icon: "assets/icons/puzzle.png", text: "Puzzle"),
              ],
            ),
            SizedBox(height: 10),
            const banner(),
            // Banner Design
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Doctor",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 46, 46, 46),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: doctor_search(),
                        ),
                      );
                    },
                    child: Text(
                      "See all",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: const Color.fromARGB(255, 3, 190, 150),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 230,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: DoctorDetails(
                              doctor: dummyDoctorList[index],
                            ),
                          ),
                        );
                      },
                      child: list_doctor2(modelsDoctor: dummyDoctorList[index]),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Health article",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 46, 46, 46),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: articlePage(),
                        ),
                      );
                    },
                    child: Text(
                      "See all",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: const Color.fromARGB(255, 3, 190, 150),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Article banner here import from widget>article
            article(
              image: "assets/images/article1.png",
              dateText: "Jun 10, 2021 ",
              duration: "5min read",
              mainText:
                  "The 25 Healthiest Fruits You Can Eat,\nAccording to a Nutritionist",
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key, this.ontap, required this.text,
  });
final void Function()? ontap;
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onTap: ontap,
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.none,
        autofocus: false,
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusColor: Colors.black26,
          fillColor: Color.fromARGB(255, 247, 247, 247),
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 10,
              width: 10,
              child: Image.asset(
                "assets/icons/search.png",
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          prefixIconColor: const Color.fromARGB(255, 3, 190, 150),
          label: Text(text),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
