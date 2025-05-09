import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class DateSelectController extends GetxController {
  var isSelected = false.obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }
}

class DateSelect extends StatelessWidget {
  final String mainText;
  final String date;

  DateSelect({required this.date, required this.mainText});

  @override
  Widget build(BuildContext context) {
    final DateSelectController controller = Get.put(DateSelectController());

    return GestureDetector(
      onTap: controller.toggleSelection,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.02,
          width: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
            color: controller.isSelected.value
                ? const Color.fromARGB(255, 2, 179, 149)
                : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mainText,
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: controller.isSelected.value ? Colors.white : Colors.black54,
                  ),
                ),
                Text(
                  date,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: controller.isSelected.value
                        ? Colors.white
                        : const Color.fromARGB(255, 27, 27, 27),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
