import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSelectController extends GetxController {
  var isSelected = false.obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }
}

class TimeSelect extends StatelessWidget {
  final String mainText;

  TimeSelect({required this.mainText});

  @override
  Widget build(BuildContext context) {
    final TimeSelectController controller = Get.put(TimeSelectController());

    return GestureDetector(
      onTap: controller.toggleSelection,
      child: Obx(() {
        return Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.2700,
          decoration: BoxDecoration(
            color: controller.isSelected.value
                ? const Color.fromARGB(255, 2, 179, 149)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mainText,
                style: TextStyle(
                  color: controller.isSelected.value
                      ? Colors.white
                      : Color.fromARGB(255, 85, 85, 85),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
