import 'package:doctor_app/doctor/ViewsDoc/questions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../constet.dart';
import '../../crud.dart';

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

class AnswerQuestionsScreenDoc extends StatelessWidget {
  final dynamic modelAsk;

  const AnswerQuestionsScreenDoc({Key? key, required this.modelAsk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnswerQuestionsController());
    controller.init(modelAsk.questionsId); // تأكد من أنها تتضمن حساب الدكتور الحالي

    return Scaffold(
      appBar: AppBar(
        title: Text("Answer Question"),
        leading: IconButton(
          onPressed: () {
            Get.to(() => QuestionsScreenDoc(), transition: Transition.leftToRight);
          },
          icon: Icon(CupertinoIcons.back),
        ),
      ),
      body: GetBuilder<AnswerQuestionsController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getComments(modelAsk.questionsId);
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // السؤال
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(CupertinoIcons.time, color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text(
                                    controller.timeAgo(modelAsk.postDate ?? ''),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text("From User", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Divider(),
                          Text(
                            modelAsk.questionsText ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // الإجابة الرئيسية
                    if (controller.answer != null)
                      Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Answer:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      controller.answer!,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      controller.timeAgo(modelAsk.postDate ?? ''),
                                      style: TextStyle(color: Colors.grey, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage: NetworkImage(
                                      controller.profileImage.isNotEmpty
                                          ? "$imageRoot/${controller.profileImage}"
                                          : "https://via.placeholder.com/150",
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Dr. ${controller.doctorName}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    controller.specialty,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Text("No answer yet"),

                    SizedBox(height: 20),

                    // باقي التعليقات
                    controller.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.commentsList.length,
                      itemBuilder: (context, index) {
                        final comment = controller.commentsList[index];
                        final docName = comment['doc_name'] ?? "Unknown";
                        final docImage = comment['doc_profile'] ?? "";
                        final commentText = comment['com_text'] ?? '';
                        final docSpecialty = comment['doc_specialty'] ?? "Not Specified";
                        final commentDate = comment['com_date'] ?? "";

                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Comment:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        commentText,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        controller.timeAgo(commentDate),
                                        style: TextStyle(color: Colors.grey, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: NetworkImage(
                                        docImage.isNotEmpty
                                            ? "$imageRoot/$docImage"
                                            : "https://via.placeholder.com/150",
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "Dr. $docName",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      docSpecialty,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20),

                    // إضافة تعليق
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.commentController,
                            decoration: InputDecoration(
                              hintText: "Add your comment...",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            controller.addComment(modelAsk.questionsId);
                          },
                          child: Text("Send"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}