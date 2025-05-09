import 'dart:convert';
import 'package:doctor_app/view/DoctorView/Login-Signup/register_doc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../../Controller/ControllerDoctor/auth/login_doc.dart';
import '../../UserView/Login-Signup/forgot_pass.dart';
import '../../UserView/Login-Signup/login.dart';
import '../../UserView/Login-Signup/login_signup.dart';
import '../Widgets/Auth_text_field.dart';
import '../Widgets/auth_social_login.dart';


class LoginDoc extends StatelessWidget {
  const LoginDoc({super.key});
  static String id = "login";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginDocController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset("assets/icons/back2.png"),
          onPressed: () => Get.off(() => login_signup()),
        ),
        centerTitle: true,
        title: Text(
          "Login",
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 110,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "W",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                  Text(
                    "elcome",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "D",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                  Text(
                    "octor",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Auth_text_field(
                validator: (value) {
                  if (value == null || value.isEmpty) return "يرجى إدخال البريد الإلكتروني";
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "يرجى إدخال بريد إلكتروني صالح";
                  return null;
                },
                controller: controller.email,
                text: "Enter your email",
                icon: "assets/icons/email.png",
              ),
              const SizedBox(height: 5),
              Auth_text_field(
                validator: (value) {
                  if (value == null || value.isEmpty) return "يرجى إدخال كلمة المرور";
                  if (value.length < 6) return "يجب أن تكون كلمة المرور على الأقل 6 أحرف";
                  return null;
                },
                controller: controller.password,
                text: "Enter your password",
                icon: "assets/icons/lock.png",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => ForgotPass()),
                    child: Text(
                      "Forgot your password?",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        color: const Color.fromARGB(255, 3, 190, 150),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() => SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: controller.loginDoc,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 3, 190, 150),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    "login",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: GoogleFonts.poppins(fontSize: 15.sp)),
                  GestureDetector(
                    onTap: () => Get.to(() => RegisterDoctorStep1()),
                    child: Text("Sign Up", style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color.fromARGB(255, 3, 190, 150), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login as a patient ? ", style: GoogleFonts.poppins(fontSize: 15.sp)),
                  GestureDetector(
                    onTap: () => Get.to(() => login()),
                    child: Text("Login", style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color.fromARGB(255, 3, 190, 150), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or", style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 30),
              auth_social_logins(
                logo: "assets/images/google.png",
                text: "Sign in with Google",
                onTap: () async {
                  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                  if (googleUser != null) {
                    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                    final String? idToken = googleAuth.idToken;
                    if (idToken != null) {
                      final response = await http.post(Uri.parse('https://yourdomain.com/api/google_login.php'), body: {'id_token': idToken});
                      final data = jsonDecode(response.body);
                      if (data['status'] == 'success') {
                        // Save and navigate
                      } else {
                        Get.snackbar("Error", "Google login failed");
                      }
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              auth_social_logins(
                logo: "assets/images/facebook.png",
                text: "Sign in with Facebook",
                onTap: () async {
                  final LoginResult result = await FacebookAuth.instance.login();
                  if (result.status == LoginStatus.success) {
                    final AccessToken accessToken = result.accessToken!;
                    final response = await http.post(Uri.parse('https://yourdomain.com/api/facebook_login.php'), body: {'access_token': accessToken.tokenString});
                    final data = jsonDecode(response.body);
                    if (data['status'] == 'success') {
                      // Save and navigate
                    } else {
                      Get.snackbar("Error", "Facebook login failed");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}