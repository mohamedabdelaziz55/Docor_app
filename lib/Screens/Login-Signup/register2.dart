import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class RegisterStep2 extends StatelessWidget {
  final Map<String, dynamic> previousData;

  RegisterStep2({required this.previousData});

  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController clinicPhoneController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  final isLoading = RxBool(false);

  Future<void> completeRegistration() async {
    isLoading.value = true;

    Map<String, dynamic> requestData = {
      ...previousData,
      "specialty": specialtyController.text.trim(),
      "clinic_phone": clinicPhoneController.text.trim(),
      "rate": rateController.text.trim(),
      "about": aboutController.text.trim(),
    };

    var url = Uri.parse('https://yourserver.com/signup.php');
    var response = await http.post(url, body: requestData);

    isLoading.value = false;

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData['status'] == true) {
        Get.snackbar('Success', 'Registration Successful');
        Get.back();
      } else {
        Get.snackbar('Error', responseData['message'] ?? 'An error occurred');
      }
    } else {
      Get.snackbar('Error', 'Server connection failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clinic Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: specialtyController,
              decoration: InputDecoration(labelText: 'Specialty'),
            ),
            TextField(
              controller: clinicPhoneController,
              decoration: InputDecoration(labelText: 'Clinic Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: rateController,
              decoration: InputDecoration(labelText: 'Rating'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: aboutController,
              decoration: InputDecoration(labelText: 'About You'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Obx(() {
              return isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: completeRegistration,
                child: Text('Register'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
