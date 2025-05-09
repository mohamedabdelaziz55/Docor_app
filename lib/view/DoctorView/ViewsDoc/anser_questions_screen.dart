import 'package:doctor_app/view/DoctorView/ViewsDoc/questions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/ControllerDoctor/ViewsController/anser_questions_screen.dart';
import '../../../constet.dart';


class AnswerQuestionsScreenDoc extends StatelessWidget {
  final dynamic modelAsk;

  const AnswerQuestionsScreenDoc({Key? key, required this.modelAsk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnswerQuestionsController());
    controller.init(modelAsk.questionsId);

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