import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/ControllerUser/Views/Screen1.dart';


class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(Screen1Controller());

    // Call the navigation method in initState using GetX
    controller.navigateToOnBoarding();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 77, 60),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                )),
          ),
        ],
      ),
    );
  }
}
