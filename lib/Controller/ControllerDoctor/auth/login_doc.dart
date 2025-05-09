import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constet.dart';
import '../../../crud.dart';
import '../../../main.dart';
import '../../../view/DoctorView/ViewsDoc/HomepageDoc.dart';

class LoginDocController extends GetxController {
  final Crud _crud = Crud();
  final GlobalKey<FormState> formKey = GlobalKey();
  final email = TextEditingController();
  final password = TextEditingController();
  var isLoading = false.obs;

  Future<void> loginDoc() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        var response = await _crud.postRequest(doclogin, {
          "doc_email": email.text,
          "doc_password": password.text,
        });

        if (response == null) throw Exception("Failed to connect to server.");

        if (response['status'] == "success") {
          await sp.setString("id", response['data']['doc_id'].toString());
          await sp.setString("userType", "doctor");
          await sp.setString("name", response['data']['doc_name']);
          await sp.setString("email", response['data']['doc_email']);
          await sp.setString("phone", response['data']['doc_phone']);
          await sp.setString("age", response['data']['doc_age']);
          await sp.setString("specialty", response['data']['doc_specialty']);
          await sp.setString("rate", response['data']['doc_rate']);
          await sp.setString("about", response['data']['doc_about']);
          await sp.setString("address", response['data']['doc_address']);
          await sp.setString("clinic_phone", response['data']['clinic_phone']);
          await sp.setString("profile_image", response['data']['doc_profile']);
          await sp.setString("image_card", response['data']['doc_imagecard']);

          Get.offAllNamed(HomepageDoc.id);
        } else {
          Get.snackbar("Error", "Login failed");
        }
      } catch (e) {
        Get.snackbar("Error", e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }
}
