import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constet.dart';
import '../../../crud.dart';
import '../../../main.dart';
import '../../../models/models_patient/model_doctors.dart';
import '../../../view/DoctorView/ViewsDoc/HomepageDoc.dart';

class EditArticlesController extends GetxController {
  var isLoading = false.obs;
  var myFile = Rxn<File>();
  var titleController = TextEditingController();
  var subtitleController = TextEditingController();

  final Crud _crud = Crud();

  void init(String title, String subtitle) {
    titleController.text = title;
    subtitleController.text = subtitle;
  }

  Future<void> editArticle(DataArtices article) async {
    if (myFile.value == null && article.imageArticles == null) {
      AwesomeDialog(
        context: Get.context!,
        title: 'Important',
        body: Text("Please add an image for the article."),
      ).show();
      return;
    }

    isLoading.value = true;

    var docId = sp.getString("id");
    if (docId == null) {
      isLoading.value = false;
      AwesomeDialog(
        context: Get.context!,
        title: 'Error',
        body: Text("Doctor ID not found."),
      ).show();
      return;
    }

    var imageFile = myFile.value ?? File(article.imageArticles ?? '');

    if (myFile.value != null && !await imageFile.exists()) {
      isLoading.value = false;
      AwesomeDialog(
        context: Get.context!,
        title: 'Error',
        body: Text("The selected image does not exist."),
      ).show();
      return;
    }

    var response = await _crud.postRequestWithFile(linkUpdateArtices, {
      "title_articles": titleController.text,
      "article_text": subtitleController.text,
      "writer_name": sp.getString("username") ?? "Unknown",
      "doc_id": docId,
      "id": article.id.toString(),
    }, imageFile);

    if (response == null) {
      isLoading.value = false;
      AwesomeDialog(
        context: Get.context!,
        title: 'Error',
        body: Text("Error connecting to the server."),
      )..show();
      return;
    }

    if (response["status"] == "success") {
      Get.to(() => HomepageDoc());
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while updating the article')),
      );
    }

    isLoading.value = false;
  }
}

