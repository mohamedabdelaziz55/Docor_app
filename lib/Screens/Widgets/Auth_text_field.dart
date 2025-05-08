import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthTextFieldController extends GetxController {

}

class AuthTextField extends StatelessWidget {
  final String text;
  final String icon;
  final TextEditingController? textController;
  final String? Function(String?)? validator;

  AuthTextField({
    required this.text,
    required this.icon,
    this.textController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final AuthTextFieldController controller = Get.put(AuthTextFieldController());

    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextFormField(
          validator: validator,
          controller: textController,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.none,
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            focusColor: Colors.black26,
            fillColor: Color.fromARGB(255, 247, 247, 247),
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 22,
                height: 22,
                child: Image.asset(icon),
              ),
            ),
            prefixIconColor: const Color.fromARGB(255, 3, 190, 150),
            label: Text(text),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
