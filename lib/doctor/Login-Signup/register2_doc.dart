import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constet.dart';
import '../../../crud.dart';
import '../Login-Signup/login_doc.dart';

class RegisterDoctorStep2Controller extends GetxController {
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController clinicPhoneController = TextEditingController();

  File? profileImage;
  File? licenseImage;

  final Crud _crud = Crud();
  bool isLoading = false;

  String docName = "", docAge = "", docEmail = "", docPassword = "", docPhone = "", gender = "", docAddress = "";

  void setData({
    required String name,
    required String age,
    required String email,
    required String password,
    required String phone,
    required String g,
    required String address,
  }) {
    docName = name;
    docAge = age;
    docEmail = email;
    docPassword = password;
    docPhone = phone;
    gender = g;
    docAddress = address;
  }

  void showImageSourceActionSheet(bool isProfile, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 150,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Pick from Camera'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  if (isProfile) {
                    profileImage = File(pickedFile.path);
                  } else {
                    licenseImage = File(pickedFile.path);
                  }
                  update();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pick from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  if (isProfile) {
                    profileImage = File(pickedFile.path);
                  } else {
                    licenseImage = File(pickedFile.path);
                  }
                  update();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerDoctor(BuildContext context) async {
    if (specialtyController.text.isEmpty || aboutController.text.isEmpty || clinicPhoneController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    if (profileImage == null || licenseImage == null) {
      Get.snackbar("Error", "Please select profile and license images");
      return;
    }

    isLoading = true;
    update();

    var data = {
      "doc_name": docName,
      "doc_age": docAge,
      "doc_email": docEmail,
      "doc_password": docPassword,
      "doc_specialty": specialtyController.text,
      "doc_phone": docPhone,
      "gender": gender,
      "doc_rate": "0",
      "doc_about": aboutController.text,
      "doc_address": docAddress,
      "clinic_phone": clinicPhoneController.text,
    };

    var response = await _crud.postRequestWithTwoFiles(
      docSignUp,
      data,
      profileImage!,
      licenseImage!,
      "doc_profile",
      "doc_imagecard",
    );

    isLoading = false;
    update();

    if (response != null && response['status'] == "success") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('doc_name', docName);

      Get.offAll(() => const LoginDoc());
    } else {
      Get.snackbar("Error", "Registration failed");
    }
  }
}

class RegisterDoctorStep2 extends StatelessWidget {
  final String docName, docAge, docEmail, docPassword, docPhone, gender, docAddress;

  const RegisterDoctorStep2({
    super.key,
    required this.docName,
    required this.docAge,
    required this.docEmail,
    required this.docPassword,
    required this.docPhone,
    required this.gender,
    required this.docAddress,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterDoctorStep2Controller>(
      init: RegisterDoctorStep2Controller()
        ..setData(
          name: docName,
          age: docAge,
          email: docEmail,
          password: docPassword,
          phone: docPhone,
          g: gender,
          address: docAddress,
        ),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Doctor Registration - Step 2')),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                TextFormField(
                  controller: controller.specialtyController,
                  decoration: const InputDecoration(labelText: 'Specialty'),
                ),
                TextFormField(
                  controller: controller.aboutController,
                  decoration: const InputDecoration(labelText: 'About You'),
                  maxLines: 4,
                ),
                TextFormField(
                  controller: controller.clinicPhoneController,
                  decoration: const InputDecoration(labelText: 'Clinic Phone'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.showImageSourceActionSheet(true, context),
                        icon: const Icon(Icons.person),
                        label: const Text("Profile Image"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.showImageSourceActionSheet(false, context),
                        icon: const Icon(Icons.credit_card),
                        label: const Text("License Card"),
                      ),
                    ),
                  ],
                ),
                if (controller.profileImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.file(controller.profileImage!, height: 100),
                  ),
                if (controller.licenseImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.file(controller.licenseImage!, height: 100),
                  ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isLoading ? null : () => controller.registerDoctor(context),
                    child: controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Complete Registration"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF03BE96),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

