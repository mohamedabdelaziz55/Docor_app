import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constet.dart';
import '../../../crud.dart';
import '../../../view/DoctorView/Login-Signup/login_doc.dart';

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

