import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/Login-Signup/login.dart';
import 'Screens/Login-Signup/register.dart';
import 'Screens/On_Board/on_boarding.dart';
import 'Screens/Views/Homepage.dart';
import 'doctor/ViewsDoc/HomepageDoc.dart';

late SharedPreferences sp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();

  String? id = sp.getString('id');
  String? userType = sp.getString('userType');

  String initialRoute;
  if (id == null) {
    initialRoute = OnBoarding.id;
  } else if (userType == 'doctor') {
    initialRoute = HomepageDoc.id;
  } else {
    initialRoute = Homepage.id;
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.ltr, // يرجّع الاتجاه زي الأول
              child: child!,
            );
          },
          getPages: [
            GetPage(name: login.id, page: () => login()),
            GetPage(name: RegisterStep1.id, page: () => RegisterStep1()),
            GetPage(name: OnBoarding.id, page: () => OnBoarding()),
            GetPage(name: Homepage.id, page: () => Homepage()),
            GetPage(name: HomepageDoc.id, page: () => HomepageDoc()),
          ],
        );
      },
    );
  }
}
