import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../main.dart';
import '../Widgets/profile_list.dart';
import 'login.dart';

class Profile_screen extends StatelessWidget {
  const Profile_screen({super.key});
  static String id = "Profile_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 226, 215),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Stack(
                children: [
                  SizedBox(height: 50),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.2),
                        )
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage("assets/icons/avatar.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.white),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/icons/camra.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sp.getString("name") ?? "اسم غير متاح",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            const SizedBox(height: 50),
            Container(
              height: 550,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  profile_list(
                    image: "assets/icons/heart2.png",
                    title: "My Saved",
                    color: Colors.black87,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  profile_list(
                    image: "assets/icons/appoint.png",
                    title: "Appointmnet",
                    color: Colors.black87,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  profile_list(
                    image: "assets/icons/Chat.png",
                    title: "FAQs",
                    color: Colors.black87,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  profile_list(
                    image: "assets/icons/pay.png",
                    title: "Payment Method",
                    color: Colors.black87,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  profile_list(
                    ontap: () async {
                      await sp.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const login()),
                            (route) => false,
                      );
                    },
                    image: "assets/icons/logout.png",
                    title: "Log out",
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
