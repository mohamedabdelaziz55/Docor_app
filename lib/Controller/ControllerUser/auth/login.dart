import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../constet.dart';
import '../../../crud.dart';
import '../../../main.dart';
import '../../../view/UserView/Views/Homepage.dart';


class LoginController extends GetxController {
  final Crud _crud = Crud();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        var response = await _crud.postRequest(linklogin, {
          "email": email.text,
          "password": password.text,
        });

        isLoading.value = false;

        if (response == null) {
          print("Error: No response from server.");
          Get.snackbar("Error", "Failed to connect to the server");
          return;
        }

        print("Server response: $response");

        if (response['status'] == "success") {
          await sp.setString("id", response['data']['id'].toString());
          await sp.setString("name", response['data']['name']);
          await sp.setString("email", response['data']['email']);
          await sp.setString("number", response['data']['number']);
          await sp.setString("age", response['data']['age']);
          await sp.setString("address", response['data']['address']);
          await sp.setString("gender", response['data']['gender']);
          await sp.setString("profile_image", response['data']['profile_image']);

          Get.offAll(() => Homepage());
        } else {
          Get.snackbar("Login Failed", response['message'] ?? "Invalid credentials");
        }
      } catch (e) {
        isLoading.value = false;
        print("Error: $e");
        Get.snackbar("Error", "Something went wrong");
      }
    }
  }
}

