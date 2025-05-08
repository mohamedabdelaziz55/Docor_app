import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:doctor_app/Screens/Login-Signup/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../../doctor/Login-Signup/login_doc.dart';
import '../../doctor/Widgets/Auth_text_field.dart';
import '../../doctor/Widgets/auth_social_login.dart';
import '../../main.dart';
import '../Views/Homepage.dart';
import 'forgot_pass.dart';
import 'login_signup.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

class login extends StatelessWidget {
  login({Key? key}) : super(key: key);
  static String id = "/login";
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.06,
            child: Image.asset("assets/icons/back2.png"),
          ),
          onPressed: () {
            Get.to(() => const login_signup(), transition: Transition.leftToRight);
          },
        ),
        centerTitle: true,
        title: Text(
          "Login",
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
        ),
        toolbarHeight: 110,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  ],
                ),
                const SizedBox(height: 30),
                Auth_text_field(
                  controller: controller.email,
                  text: "Enter your email",
                  icon: "assets/icons/email.png",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Auth_text_field(
                  controller: controller.password,
                  text: "Enter your password",
                  icon: "assets/icons/lock.png",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ForgotPassController(), transition: Transition.downToUp);
                      },
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
                SizedBox(height: 10),
                Obx(() {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 3, 190, 150),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => RegisterStep1(), transition: Transition.rightToLeft);
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: const Color.fromARGB(255, 3, 190, 150),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Want to login as a doctor? ",
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => LoginDoc(), transition: Transition.rightToLeft);
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: const Color.fromARGB(255, 3, 190, 150),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        final response = await http.post(
                          Uri.parse('https://yourdomain.com/api/google_login.php'),
                          body: {'id_token': idToken},
                        );

                        final data = jsonDecode(response.body);
                        if (data['status'] == 'success') {
                          // Save user data and redirect to homepage
                        } else {
                          // Show error message
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
                      final String token = accessToken.tokenString;

                      final response = await http.post(
                        Uri.parse('https://yourdomain.com/api/facebook_login.php'),
                        body: {'access_token': token},
                      );

                      final data = jsonDecode(response.body);
                      if (data['status'] == 'success') {
                        // Save user data and redirect to homepage
                      } else {
                        // Show error message
                      }
                    } else {
                      // Show error message
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
