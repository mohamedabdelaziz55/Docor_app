import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_app/constet.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String gender = "ذكر";

  File? imageFile;
  String? existingImage;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = sp.getString("name") ?? "";
      emailController.text = sp.getString("email") ?? "";
      numberController.text = sp.getString("number") ?? "";
      ageController.text = sp.getString("age") ?? "";
      addressController.text = sp.getString("address") ?? "";
      gender = sp.getString("gender") ?? "ذكر";
      existingImage = sp.getString("profile_image");
    });
  }

  Future<void> pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> updateProfile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final id = sp.getString("id");

    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ، لم يتم العثور على معرف المستخدم")),
      );
      return;
    }

    final uri = Uri.parse("");
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = id;
    request.fields['name'] = nameController.text;
    request.fields['email'] = emailController.text;
    request.fields['number'] = numberController.text;
    request.fields['age'] = ageController.text;
    request.fields['address'] = addressController.text;
    request.fields['gender'] = gender;

    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profile_image', imageFile!.path),
      );
    }

    final response = await request.send();
    final resBody = await response.stream.bytesToString();

    print("Response Body: $resBody");
    print("Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      final newImageName =
      imageFile != null ? imageFile!.path.split("/").last : existingImage;

      await sp.setString("name", nameController.text);
      await sp.setString("email", emailController.text);
      await sp.setString("number", numberController.text);
      await sp.setString("age", ageController.text);
      await sp.setString("address", addressController.text);
      await sp.setString("gender", gender);
      if (newImageName != null) {
        await sp.setString("profile_image", newImageName);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم تحديث البيانات بنجاح")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل في تحديث البيانات")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل الملف الشخصي"),
        centerTitle: true,
      ),
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
                      : existingImage != null
                      ? NetworkImage("$imageRoot/$existingImage")
                  as ImageProvider
                      : const AssetImage("assets/icons/avatar.png"),
                ),
              ),
              const SizedBox(height: 20),
              buildTextField(nameController, "الاسم"),
              buildTextField(emailController, "البريد الإلكتروني"),
              buildTextField(numberController, "رقم الهاتف",
                  keyboardType: TextInputType.phone),
              buildTextField(ageController, "العمر",
                  keyboardType: TextInputType.number),
              buildTextField(addressController, "العنوان"),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: gender,
                items: ['ذكر', 'أنثى'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 17.sp)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "النوع",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
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
                child: Text("حفظ التعديل", style: TextStyle(fontSize: 17.sp)),
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "هذا الحقل مطلوب";
          }
          return null;
        },
      ),
    );
  }
}
