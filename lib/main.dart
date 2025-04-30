import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
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
    initialRoute = on_boarding.id;
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
        return DevicePreview(
          builder: (context) => MaterialApp(
            useInheritedMediaQuery: true,
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
            routes: {
              login.id: (context) => login(),
              Homepage.id: (context) => Homepage(),
              HomepageDoc.id: (context) => HomepageDoc(),
              RegisterStep1.id: (context) => RegisterStep1(),
              on_boarding.id: (context) => on_boarding(),
            },
          ),
        );
      },
    );
  }
}
