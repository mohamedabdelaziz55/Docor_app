import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view/DoctorView/Login-Signup/register2_doc.dart';


class RegisterDoctorController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var gender = 'Male'.obs;

  void goToNextStep() {
    if (formKey.currentState!.validate()) {
      Get.to(
        () => RegisterDoctorStep2(
          docName: nameController.text,
          docAge: ageController.text,
          docEmail: emailController.text,
          docPassword: passwordController.text,
          docPhone: phoneController.text,
          gender: gender.value,
          docAddress: addressController.text,
        ),
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
