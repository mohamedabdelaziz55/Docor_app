import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constet.dart';
import '../../main.dart';
import '../Widgets/profile_list.dart';
import 'EditProfileScreen.dart';
import 'login.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});
  static String id = "Profile_screen";

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  String? name, email, number, age, address, gender, profileImage;

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  void loadProfileData() {
    name =  sp.getString("name");
    email =  sp.getString("email");
    number =  sp.getString("number");
    age =  sp.getString("age");
    address =  sp.getString("address");
    gender =  sp.getString("gender");
    profileImage =  sp.getString("profile_image");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 190, 150),
      body: RefreshIndicator(
        onRefresh: () async => loadProfileData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Stack(
                  children: [
                    const SizedBox(height: 50),
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
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: profileImage != null
                              ? NetworkImage("$imageRoot/$profileImage")
                              : const AssetImage("assets/icons/avatar.png")
                          as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                name ?? "Unknown Name",
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  );
                  loadProfileData();
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
              Text(
                email ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: Colors.white70,
                ),
              ),
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
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    profile_list(
                      image: "assets/icons/call.png",
                      title: "Phone: $number",
                      color: Colors.black87,
                    ),
                    profile_list(
                      image: "assets/icons/calendar.png",
                      title: "Age: $age",
                      color: Colors.black87,
                    ),
                    profile_list(
                      image: "assets/icons/location.png",
                      title: "Address: $address",
                      color: Colors.black87,
                    ),
                    profile_list(
                      image: "assets/icons/gender.png",
                      title: "Gender: $gender",
                      color: Colors.black87,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await  sp.clear(); // مسح البيانات من SharedPreferences
                        print("User logged out.");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const login()), // تأكد إن login مستورد صح
                              (route) => false,
                        );
                      },
                      child: Row(
                        children: [
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
