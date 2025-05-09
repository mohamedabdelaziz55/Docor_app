import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../Controller/ControllerDoctor/auth/Profile_screen.dart';
import '../../../constet.dart';
import '../../../main.dart';
import '../../UserView/Login-Signup/login.dart';
import 'EditProfileDocScreen.dart';


class Profile_Doc_screen extends StatelessWidget {
  const Profile_Doc_screen({super.key});
  static String id = "Profile_screen";

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => profileController.loadProfileData(),
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF03BE96), Color(0xFF018786)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          image: DecorationImage(
                            image: profileController.profileImage.value.isNotEmpty
                                ? NetworkImage("$imageRoot/${profileController.profileImage.value}")
                                : const AssetImage("assets/icons/avatar.png")
                            as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => Text(
                  profileController.name.value,
                  style: GoogleFonts.poppins(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
                const SizedBox(height: 5),
                Obx(() => Text(
                  profileController.email.value,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.white70,
                  ),
                )),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditProfileDocScreen()),
                    );
                    profileController.loadProfileData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF03BE96),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  ),
                  child: Text(
                    "editProfile",
                    style: GoogleFonts.poppins(
                        fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Obx(() => ProfileCard(
                        icon: "assets/icons/call.png",
                        text: "Phone: ${profileController.number.value}",
                      )),
                      Obx(() => ProfileCard(
                        icon: "assets/icons/calendar.png",
                        text: "Age: ${profileController.age.value}",
                      )),
                      Obx(() => ProfileCard(
                        icon: "assets/icons/location.png",
                        text: "Address: ${profileController.address.value}",
                      )),
                      Obx(() => ProfileCard(
                        icon: "assets/icons/gender.png",
                        text:
                        "Gender: ${profileController.gender.value}",
                      )),
                      const SizedBox(height: 20),
                      Divider(color: Colors.grey.shade400),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          await sp.clear();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => login()),
                                (route) => false,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.logout, color: Colors.redAccent),
                              SizedBox(width: 10),
                              Text(
                                "Log Out",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String icon;
  final String text;

  const ProfileCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.asset(icon, width: 28),
        title: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 15.sp, color: Colors.black87),
        ),
      ),
    );
  }
}
