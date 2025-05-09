import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constet.dart';
import '../../../crud.dart';
import '../../../view/UserView/Views/questions_screen.dart';

class EditPostController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController text = TextEditingController();
  final Crud _crud = Crud();

  late String postId;

  Future<void> updatePost() async {
    var response = await _crud.postRequest(
      linkEdit,
      {
        "questions_id": postId,
        "questions_text": text.text,
      },
    );

    if (response["status"] == "success") {
      Get.snackbar("Success", "Question updated successfully",
          backgroundColor: Colors.green.shade100);
      Get.off(() => QuestionsScreen());
    } else {
      Get.snackbar("Error", "Failed to update question",
          backgroundColor: Colors.red.shade100);
    }
  }
}
