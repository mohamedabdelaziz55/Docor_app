import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/ControllerUser/Views/edit_ask_screen.dart';
import '../../../view/UserView/Views/questions_screen.dart';


class EditPostScreen extends StatelessWidget {
  final String postId;
  final String currentText;

  const EditPostScreen({
    super.key,
    required this.postId,
    required this.currentText,
  });

  @override
  Widget build(BuildContext context) {
    final EditPostController controller = Get.put(EditPostController());
    controller.text.text = currentText;
    controller.postId = postId;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.off(() => QuestionsScreen());
          },
        ),
        title: Text('Edit Question'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Your Question',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 190, 150),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.text,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your question.';
                  }
                  return null;
                },
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Your Question',
                  hintText: 'Update your question here...',
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      await controller.updatePost();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 3, 190, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text(
                      'Update Question',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
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
