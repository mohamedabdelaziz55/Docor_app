import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../Views/Homepage.dart';
import '../Widgets/Auth_text_field.dart';


class RegisterStep1 extends StatefulWidget {
  const RegisterStep1({super.key});
  static String id = "RegisterStep1";

  @override
  State<RegisterStep1> createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController address = TextEditingController();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign up - Step 1", style: GoogleFonts.inter(fontSize: 22.sp, fontWeight: FontWeight.w700, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Auth_text_field(text: "Enter your name", icon: "assets/icons/person.png", controller: name, validator: _validateNotEmpty),
              Auth_text_field(text: "Enter your email", icon: "assets/icons/email.png", controller: email, validator: _validateEmail),
              Auth_text_field(text: "Enter your password", icon: "assets/icons/lock.png", controller: password, validator: _validatePassword),
              Auth_text_field(text: "Enter your Number", icon: "assets/icons/call.png", controller: number, validator: _validateNotEmpty),
              Auth_text_field(text: "Enter your Age", icon: "assets/icons/calendar.png", controller: age, validator: _validateNotEmpty),
              Auth_text_field(text: "Enter your Address", icon: "assets/icons/location.png", controller: address, validator: _validateNotEmpty),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.wc),
                  labelText: "Select your gender",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                value: selectedGender,
                items: ["Male", "Female"].map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
                onChanged: (val) => setState(() => selectedGender = val),
                validator: (value) => value == null ? "Please select your gender" : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: RegisterStepTwo(
                            name: name.text,
                            email: email.text,
                            password: password.text,
                            number: number.text,
                            age: age.text,
                            address: address.text,
                            gender: selectedGender!,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 3, 190, 150),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text("Continue", style: TextStyle(fontSize: 18.sp, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateNotEmpty(String? value) => (value == null || value.isEmpty) ? "Field cannot be empty" : null;
  String? _validateEmail(String? value) => (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value ?? '')) ? "Enter a valid email" : null;
  String? _validatePassword(String? value) => (value != null && value.length < 6) ? "Password must be at least 6 characters" : null;
}


class RegisterStepTwo extends StatefulWidget {
  final String name, email, password, number, age, address, gender;
  const RegisterStepTwo({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.number,
    required this.age,
    required this.address,
    required this.gender,
  });

  @override
  State<RegisterStepTwo> createState() => _RegisterStepTwoState();
}

class _RegisterStepTwoState extends State<RegisterStepTwo> {
  File? myfile;
  final String defaultImagePath = 'assets/icons/female-doctor2.png';
  final Crud _crud = Crud();
  bool isLoading = false;

  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Pick from Gallery"),
            onTap: () async {
              XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (xfile != null) {
                setState(() {
                  myfile = File(xfile.path);
                });
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Take a Photo"),
            onTap: () async {
              XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
              if (xfile != null) {
                setState(() {
                  myfile = File(xfile.path);
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> completeRegistration() async {
    setState(() => isLoading = true);

    File? fileToSend = myfile;
    var response;

    if (fileToSend != null) {
      response = await _crud.postRequestWithFile(
        linkSignUp,
        {
          "name": widget.name,
          "email": widget.email,
          "password": widget.password,
          "number": widget.number,
          "age": widget.age,
          "address": widget.address,
          "gender": widget.gender,
        },
        fileToSend,
      );
    } else {
      // بدون صورة
      response = await _crud.postRequest(
        linkSignUp,
        {
          "name": widget.name,
          "email": widget.email,
          "password": widget.password,
          "number": widget.number,
          "age": widget.age,
          "address": widget.address,
          "gender": widget.gender,
          "noimage": "1", // نبعته كإشارة إنه مفيش صورة
        },
      );
    }

    setState(() => isLoading = false);

    if (response['status'] == "success") {
      Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.fade, child: Homepage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("فشل في إنشاء الحساب")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Profile Image"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: myfile != null
                  ? FileImage(myfile!)
                  : AssetImage(defaultImagePath) as ImageProvider,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: showImagePicker,
              icon: const Icon(Icons.upload, color: Colors.white),
              label: const Text("Upload Image", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF03BE96),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : completeRegistration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03BE96),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
