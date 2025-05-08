import 'package:doctor_app/doctor/Widgets/profile_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constet.dart';
import '../../doctor/Login-Signup/EditProfileDocScreen.dart';
import '../../main.dart';
import 'login.dart';



class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var number = ''.obs;
  var age = ''.obs;
  var address = ''.obs;
  var gender = ''.obs;
  var profileImage = ''.obs;

  void loadProfileData() {
    name.value = sp.getString("name") ?? '';
    email.value = sp.getString("email") ?? '';
    number.value = sp.getString("number") ?? '';
    age.value = sp.getString("age") ?? '';
    address.value = sp.getString("address") ?? '';
    gender.value = sp.getString("gender") ?? '';
    profileImage.value = sp.getString("profile_image") ?? '';
  }

  void clearProfile() async {
    await sp.clear();
  }

  @override
  void onInit() {
    loadProfileData();
    super.onInit();
  }
}

class Profile_screen extends StatelessWidget {
  const Profile_screen({super.key});
  static String id = "Profile_screen";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 190, 150),
      body: RefreshIndicator(
        onRefresh: () async => controller.loadProfileData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Obx(() => Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withValues(alpha: 0.2),
                      ),
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: controller.profileImage.value.isNotEmpty
                          ? NetworkImage("$imageRoot/${controller.profileImage.value}")
                          : const AssetImage("assets/icons/avatar.png")
                      as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 30),
              Obx(() => Text(
                controller.name.value.isNotEmpty
                    ? controller.name.value
                    : "Unknown Name",
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () async {
                  await Get.to(() => const EditProfileDocScreen());
                  controller.loadProfileData();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Edit Profile",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: const Color.fromARGB(255, 3, 190, 150),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => Text(
                controller.email.value,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: Colors.white70,
                ),
              )),
              const SizedBox(height: 30),
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
                child: Obx(() => Column(
                  children: [
                    const SizedBox(height: 30),
                    ProfileList(
                      image: "assets/icons/call.png",
                      title: "Phone: ${controller.number.value}",
                      color: Colors.black87,
                    ),
                    ProfileList(
                      image: "assets/icons/calendar.png",
                      title: "Age: ${controller.age.value}",
                      color: Colors.black87,
                    ),
                    ProfileList(
                      image: "assets/icons/location.png",
                      title: "Address: ${controller.address.value}",
                      color: Colors.black87,
                    ),
                    ProfileList(
                      image: "assets/icons/gender.png",
                      title: "Gender: ${controller.gender.value}",
                      color: Colors.black87,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await sp.clear();
                        Get.offAll(() =>  login());
                      },
                      child: Row(
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
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
