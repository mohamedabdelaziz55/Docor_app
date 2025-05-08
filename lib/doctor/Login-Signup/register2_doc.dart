import 'dart:io';
import 'package:doctor_app/doctor/Login-Signup/login_doc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constet.dart';
import '../../../crud.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ViewsDoc/HomepageDoc.dart';

class RegisterDoctorStep2 extends StatefulWidget {
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
  State<RegisterDoctorStep2> createState() => _RegisterDoctorStep2State();
}

class _RegisterDoctorStep2State extends State<RegisterDoctorStep2> {
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController clinicPhoneController = TextEditingController();

  File? profileImage;
  File? licenseImage;

  final Crud _crud = Crud();
  bool isLoading = false;

  void pickImage(bool isProfile) async {
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
                  setState(() {
                    if (isProfile) {
                      profileImage = File(pickedFile.path);
                    } else {
                      licenseImage = File(pickedFile.path);
                    }
                  });
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
                  setState(() {
                    if (isProfile) {
                      profileImage = File(pickedFile.path);
                    } else {
                      licenseImage = File(pickedFile.path);
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerDoctor() async {
    if (specialtyController.text.isEmpty || aboutController.text.isEmpty || clinicPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }
    if (profileImage == null || licenseImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select profile and license images")),
      );
      return;
    }

    setState(() => isLoading = true);

    var data = {
      "doc_name": widget.docName,
      "doc_age": widget.docAge,
      "doc_email": widget.docEmail,
      "doc_password": widget.docPassword,
      "doc_specialty": specialtyController.text,
      "doc_phone": widget.docPhone,
      "gender": widget.gender,
      "doc_rate": "0",
      "doc_about": aboutController.text,
      "doc_address": widget.docAddress,
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

    setState(() => isLoading = false);

    if (response != null && response['status'] == "success") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('doc_name', widget.docName);

      Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.fade, child: LoginDoc()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Registration - Step 2')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextFormField(
              controller: specialtyController,
              decoration: const InputDecoration(labelText: 'Specialty'),
            ),
            TextFormField(
              controller: aboutController,
              decoration: const InputDecoration(labelText: 'About You'),
              maxLines: 4,
            ),
            TextFormField(
              controller: clinicPhoneController,
              decoration: const InputDecoration(labelText: 'Clinic Phone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => pickImage(true),
                    icon: const Icon(Icons.person),
                    label: const Text("Profile Image"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => pickImage(false),
                    icon: const Icon(Icons.credit_card),
                    label: const Text("License Card"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : registerDoctor,
                child: isLoading
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
  }
}
