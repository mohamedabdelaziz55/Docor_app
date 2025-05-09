import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../../constet.dart';
import '../../../crud.dart';


class AnswerQuestionsController extends GetxController {
  final Crud _crud = Crud();
  final TextEditingController commentController = TextEditingController();

  List commentsList = [];
  bool isLoading = false;

  String? docId;
  String doctorName = "Unknown";
  String specialty = "Not Specified";
  String profileImage = "";
  String? answer;

  Future<void> init(String questionId) async {
    await fetchDoctorInfo();
    await getComments(questionId);
  }

  Future<void> fetchDoctorInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    docId = sp.getString("id");
    doctorName = sp.getString("name") ?? "Unknown";
    specialty = sp.getString("specialty") ?? "Not Specified";
    profileImage = sp.getString("profile_image") ?? "";
    update(); // تحديث الواجهة بعد تحميل المعلومات
  }

  Future<void> getComments(String questionId) async {
    isLoading = true;
    update();

    var response = await _crud.getRequest("$viewComments?ask_id=$questionId");

    try {
      if (response != null && response['status'] == 'success') {
        List fullComments = response['data'];

        if (fullComments.isNotEmpty) {
          answer = fullComments.first['com_text'];
          doctorName = fullComments.first['doc_name'] ?? doctorName;
          specialty = fullComments.first['doc_specialty'] ?? specialty;
          profileImage = fullComments.first['doc_profile'] ?? profileImage;
          commentsList = fullComments.sublist(1); // باقي التعليقات
        } else {
          answer = null;
          commentsList = [];
        }
      } else {
        commentsList = [];
      }
    } catch (e) {
      print("Error fetching comments: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> addComment(String questionId) async {
    if (commentController.text.isEmpty) return;

    var response = await _crud.postRequest(addComments, {
      "com_text": commentController.text,
      "doc_id": docId,
      "ask_id": questionId,
    });

    try {
      if (response != null && response['status'] == 'success') {
        commentController.clear();
        await getComments(questionId); // تحديث التعليقات بعد الإضافة
        await fetchDoctorInfo(); // تحديث بيانات الدكتور بعد إضافة التعليق
      } else {
        print("Failed to add comment: ${response.toString()}");
      }
    } catch (e) {
      print("Error adding comment: $e");
    }
  }

  String timeAgo(String dateTime) {
    try {
      DateTime postDate = DateTime.parse(dateTime).toLocal();
      DateTime now = DateTime.now().toLocal();
      final Duration difference = now.difference(postDate);

      if (difference.inSeconds < 60) {
        return "Just now";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} minute(s) ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hour(s) ago";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} day(s) ago";
      } else if (difference.inDays < 30) {
        return "${difference.inDays ~/ 7} week(s) ago";
      } else if (difference.inDays < 365) {
        return "${difference.inDays ~/ 30} month(s) ago";
      } else {
        return "${difference.inDays ~/ 365} year(s) ago";
      }
    } catch (_) {
      return "Unknown date";
    }
  }
}

