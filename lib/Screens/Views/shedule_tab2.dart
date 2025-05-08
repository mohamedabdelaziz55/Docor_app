import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScheduleTab2Controller extends GetxController {
  // يمكنك إضافة أي منطق تحتاجه هنا في المستقبل
}

class ScheduleTab2 extends StatelessWidget {
  const ScheduleTab2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleTab2Controller());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            "Nothing to show",
            style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        )
      ]),
    );
  }
}
