import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constet.dart';
import '../../../crud.dart';
import '../../../main.dart';
import '../../../view/DoctorView/ViewsDoc/HomepageDoc.dart';

class AddArticlesController extends GetxController {
  var myfile = Rx<File?>(null);
  var isloading = false.obs;
  var title = TextEditingController();
  var subtitle = TextEditingController();
  final Crud _crud = Crud();

  addArticles() async {
    if (myfile.value == null) {
      AwesomeDialog(
        context: Get.context!,
        title: 'Important',
        body: Text("Please add an image for the article."),
      ).show();
      return;
    }

    isloading.value = true;

    if (title.text.isEmpty || subtitle.text.isEmpty) {
      AwesomeDialog(
        context: Get.context!,
        title: 'Error',
        body: Text("Please fill in all fields."),
      ).show();
      isloading.value = false;
      return;
    }

    var docId = sp.getString("id");
    if (docId == null) {
      isloading.value = false;
      AwesomeDialog(
        context: Get.context!,
        title: 'Error',
        body: Text("Doctor ID not found."),
      ).show();
      return;
    }

    var response = await _crud.postRequestWithFile(linkAddArtices, {
      "title_articles": title.text,
      "article_text": subtitle.text,
      "writer_name": sp.getString("username") ?? "Unknown",
      "doc_id": docId,
    }, myfile.value!);

    if (response["status"] == "success") {
      Get.to(() => HomepageDoc());
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error adding the article')),
      );
    }

    isloading.value = false;
  }
}

