import 'package:flutter/material.dart';
import 'package:get/get.dart' ;
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/ControllerDoctor/auth/EditProfileDocScreen.dart';
import '../../../constet.dart';

class EditProfileDocScreen extends StatelessWidget {
  const EditProfileDocScreen({super.key});
  static String id = "EditProfile_screen";

  @override
  Widget build(BuildContext context) {
    final EditProfileController controller = Get.put(EditProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'editProfile',
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF03BE96),
      ),
      body: Obx(() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  await controller.pickImage();
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: controller.profileImage.value.isNotEmpty
                      ? controller.profileImage.value.startsWith('/')
                      ? FileImage(File(controller.profileImage.value))
                      : NetworkImage("$imageRoot/${controller.profileImage.value}") as ImageProvider
                      : const AssetImage("assets/icons/avatar.png"),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField('name', controller.name),
               SizedBox(height: 10),
              _buildTextField('email', controller.email),
               SizedBox(height: 10),
              _buildTextField('phone', controller.number),
               SizedBox(height: 10),
              _buildTextField('age', controller.age),
               SizedBox(height: 10),
              _buildTextField('address', controller.address),
               SizedBox(height: 10),
              _buildTextField('gender', controller.gender),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final sp = await SharedPreferences.getInstance();
                  await sp.setString("name", controller.name.value);
                  await sp.setString("email", controller.email.value);
                  await sp.setString("phone", controller.number.value);
                  await sp.setString("age", controller.age.value);
                  await sp.setString("address", controller.address.value);
                  await sp.setString("gender", controller.gender.value);

                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03BE96),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                ),
                child: Text(
                  'saveChanges',
                  style: GoogleFonts.poppins(fontSize: 15.sp, fontWeight: FontWeight.w500),
                )
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildTextField(String labelKey, RxString value) {
    return Obx(() => TextField(
      onChanged: (val) => value.value = val,
      controller: TextEditingController(text: value.value)
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: value.value.length),
        ),
      decoration: InputDecoration(
        labelText: labelKey,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ));
  }
}