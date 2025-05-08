import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  File? imageFile;
  String? existingImage;
  String gender = "Male";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = sp.getString("name") ?? "";
      emailController.text = sp.getString("email") ?? "";
      numberController.text = sp.getString("number") ?? "";
      ageController.text = sp.getString("age") ?? "";
      addressController.text = sp.getString("address") ?? "";
      gender = (sp.getString("gender") == "ذكر") ? "Male" : "Female";
      existingImage = sp.getString("profile_image");
    });
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future<void> updateProfile() async {
    final prefs = await SharedPreferences.getInstance();

    // تخزين البيانات المحلية
    prefs.setString("name", nameController.text);
    prefs.setString("email", emailController.text);
    prefs.setString("number", numberController.text);
    prefs.setString("age", ageController.text);
    prefs.setString("address", addressController.text);
    prefs.setString("gender", gender);

    if (imageFile != null) {
      // إذا تم تحديد صورة جديدة، نقوم بتخزين المسار المحلي للصورة
      prefs.setString("profile_image", imageFile!.path);
    }

    Get.snackbar("Success", "Profile updated locally", snackPosition: SnackPosition.BOTTOM);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : (existingImage != null
                      ? FileImage(File(existingImage!))
                      : const AssetImage("assets/icons/avatar.png")) as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),
              buildTextField(nameController, "Name"),
              buildTextField(emailController, "Email"),
              buildTextField(numberController, "Phone Number", keyboardType: TextInputType.phone),
              buildTextField(ageController, "Age", keyboardType: TextInputType.number),
              buildTextField(addressController, "Address"),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: gender,
                items: ['Male', 'Female']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g, style: TextStyle(fontSize: 17.sp))))
                    .toList(),
                onChanged: (val) => setState(() => gender = val!),
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateProfile();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03BE96),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text("Save", style: TextStyle(fontSize: 17.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
        validator: (value) => (value == null || value.isEmpty) ? "Required field" : null,
      ),
    );
  }
}
