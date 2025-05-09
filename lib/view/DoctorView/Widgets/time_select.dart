import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSelect extends StatefulWidget {
  final String mainText;

  TimeSelect({required this.mainText});

  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  RxBool isSelected = false.obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSelection,
      child: Obx(() => Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.2700,
        decoration: BoxDecoration(
          color: isSelected.value
              ? const Color.fromARGB(255, 2, 179, 149)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.mainText,
              style: TextStyle(
                color: isSelected.value
                    ? Colors.white
                    : const Color.fromARGB(255, 85, 85, 85),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
