import 'dart:convert';
import 'package:doctor_app/doctor/Login-Signup/register_doc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../crud.dart';
import '../../../main.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../Screens/Login-Signup/forgot_pass.dart';
import '../../Screens/Login-Signup/login.dart';
import '../../Screens/Login-Signup/login_signup.dart';
import '../../Screens/Widgets/Auth_text_field.dart';
import '../../Screens/Widgets/auth_social_login.dart';
import '../../constet.dart';
import '../ViewsDoc/HomepageDoc.dart';

class login_Doc extends StatefulWidget {
  const login_Doc({super.key});
  static String id = "login";

  @override
  State<login_Doc> createState() => _login_DocState();
}

class _login_DocState extends State<login_Doc> {
  final Crud _crud = Crud();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isLoading = false;

  Future<void> LoginDoc() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        var response = await _crud.postRequest(doclogin, {
          "doc_email": email.text,
          "doc_password": password.text,
        });

        if (response == null) {
          throw Exception("فشل الاتصال بالخادم.");
        }

        if (response['status'] == "success") {
          await sp.setString("id", response['data']['doc_id'].toString());
          await sp.setString("userType", "doctor"); // <<<<< ده السطر المهم جداً
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


          Navigator.pushReplacementNamed(context, HomepageDoc.id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("فشل تسجيل الدخول")),
          );
        }
      } catch (e) {
        print("خطأ: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("حدث خطأ: ${e.toString()}")),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }
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
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: login_signup(),
              ),
            );
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
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Auth_text_field(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى إدخال البريد الإلكتروني";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "يرجى إدخال بريد إلكتروني صالح";
                    }
                    return null;
                  },
                  controller: email,
                  text: "Enter your email",
                  icon: "assets/icons/email.png",
                ),
                const SizedBox(height: 5),
                Auth_text_field(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى إدخال كلمة المرور";
                    }
                    if (value.length < 6) {
                      return "يجب أن تكون كلمة المرور على الأقل 6 أحرف";
                    }
                    return null;
                  },
                  controller: password,
                  text: "Enter your password",
                  icon: "assets/icons/lock.png",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: forgot_pass(),
                          ),
                        );
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () async {
                      await LoginDoc();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 3, 190, 150),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                      "login",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: RegisterDoctorStep1 (),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
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
                      "Login as a patient ? ",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: login(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
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
                          // حفظ بيانات المستخدم وتوجيهه إلى الصفحة الرئيسية
                        } else {
                          // عرض رسالة خطأ
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
                        // حفظ بيانات المستخدم وتوجيهه إلى الصفحة الرئيسية
                      } else {
                        // عرض رسالة خطأ
                      }
                    } else {
                      // عرض رسالة خطأ
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
