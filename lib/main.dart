import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Login-Signup/login.dart';
import 'Screens/Login-Signup/register.dart';
import 'Screens/On_Board/on_boarding.dart';
import 'Screens/Views/Homepage.dart';

late SharedPreferences sp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  runApp(const Medics());
}

class Medics extends StatelessWidget {
  const Medics({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return DevicePreview(builder:(context)=>MaterialApp( useInheritedMediaQuery: true,
          builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            initialRoute: sp.getString('id') == null ? on_boarding.id : Homepage.id, // <<< هنا التعديل
            routes: {
              login.id: (context) => login(),
              Homepage.id: (context) => Homepage(),
              RegisterStep1.id: (context) => RegisterStep1(),
              on_boarding.id: (context) => on_boarding(), // <<< لازم تضيفي الصفحة في الروتز
            },
          ),
        );
      },
    );
  }
}
