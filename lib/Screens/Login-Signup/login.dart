import 'package:doctor_app/Screens/Login-Signup/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../Views/Homepage.dart';
import '../Widgets/Auth_text_field.dart';
import '../Widgets/auth_social_login.dart';
import 'forgot_pass.dart';
import 'login_signup.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final Crud _crud = Crud();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isLoading = false;

  Future<void> LoginPhp() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      var response = await _crud.postRequest(linklogin, {
        "email": email.text,
        "password": password.text,
      });

      setState(() => isLoading = false);

      if (response['status'] == "success") {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Homepage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("فشل")));
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              //Text field Login import from Auth_text_field widget
              Auth_text_field(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "يرجى إدخال البريد الإلكتروني";
                  }
                  // التحقق من صحة البريد الإلكتروني باستخدام Regex
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "يرجى إدخال بريد إلكتروني صالح";
                  }
                  return null; // ✅ لا يوجد خطأ
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
                    await LoginPhp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 3, 190, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await LoginPhp();
                    },
                    child:
                        isLoading == true
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
                          child: Register(),
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
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
              ),
              const SizedBox(height: 20),
              auth_social_logins(
                logo: "assets/images/apple.png",
                text: "Sign in Apple",
              ),
              const SizedBox(height: 20),
              auth_social_logins(
                logo: "assets/images/facebook.png",
                text: "Sign in facebook",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
