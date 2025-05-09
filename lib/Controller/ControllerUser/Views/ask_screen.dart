import 'package:doctor_app/crud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constet.dart';
import '../../../main.dart';
import '../../../view/UserView/Views/questions_screen.dart';


class AskController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController text = TextEditingController();
  final Crud _crud = Crud();

  Future<void> addPost() async {
    final userId = sp.getString("id");
    if (userId == null || text.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a question and make sure you're logged in.",
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
      );
      return;
    }

    var response = await _crud.postRequest(linkAdd, {
      "questions_text": text.text,
      "id": userId,
    });

    if (response["status"] == "success") {
      Get.snackbar(
        "Success",
        "Question submitted successfully",
        backgroundColor: Colors.green.shade100,
        colorText: Colors.black,
      );
      text.clear();
      Get.off(() => QuestionsScreen());
    } else {
      Get.snackbar(
        "Error",
        "Failed to submit question. Please try again.",
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
      );
    }
  }
}

class AskScreen extends StatelessWidget {
  const AskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AskController controller = Get.put(AskController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.off(() => QuestionsScreen());
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ask Your Question',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 190, 150),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Please provide as much detail as possible to help us assist you better.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Type your question here...',
                  labelText: 'Your Question',
                  labelStyle: TextStyle(color: Colors.black54),
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 190, 150),
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      await controller.addPost();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 3, 190, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      'Publish Question',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 247, 247, 247),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
