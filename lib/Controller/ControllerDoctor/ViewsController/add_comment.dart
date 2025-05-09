import 'package:doctor_app/constet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../../crud.dart';


class AddCommentController extends GetxController {
  final Crud _crud = Crud();
  var commentController = TextEditingController();
  var commentsList = <dynamic>[].obs;
  var isLoading = false.obs;
  late String docId;

  Future<void> fetchDoctorId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    docId = sp.getString("id") ?? "";
  }

  Future<void> getComments(String askId) async {
    isLoading.value = true;
    var response = await _crud.postRequest(viewComments, {
      "ask_id": askId,
    });

    if (response['status'] == 'success') {
      commentsList.value = response['data'];
    }

    isLoading.value = false;
  }

  Future<void> addComment(String askId) async {
    if (commentController.text.isEmpty) return;
    var response = await _crud.postRequest(addComments, {
      "com_text": commentController.text,
      "doc_id": docId,
      "ask_id": askId,
    });

    if (response['status'] == 'success') {
      commentController.clear();
      getComments(askId);
    }
  }
}

