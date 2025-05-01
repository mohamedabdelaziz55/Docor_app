import 'package:doctor_app/doctor/ViewsDoc/questions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constet.dart';
import '../../crud.dart';

class AnswerQuestionsScreenDoc extends StatefulWidget {
  final dynamic modelAsk;

  const AnswerQuestionsScreenDoc({Key? key, required this.modelAsk}) : super(key: key);

  @override
  State<AnswerQuestionsScreenDoc> createState() => _AnswerQuestionsScreenDocState();
}

class _AnswerQuestionsScreenDocState extends State<AnswerQuestionsScreenDoc> {
  final TextEditingController _commentController = TextEditingController();
  final Crud _crud = Crud();

  List commentsList = [];
  bool isLoading = false;

  String? docId;
  String doctorName = "Unknown";
  String specialty = "Not Specified";
  String profileImage = "";
  String? answer;

  @override
  void initState() {
    super.initState();
    fetchDoctorInfo().then((_) => getComments());
  }

  Future<void> fetchDoctorInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    docId = sp.getString("id");
    doctorName = sp.getString("name") ?? "Unknown";
    specialty = sp.getString("specialty") ?? "Not Specified";
    profileImage = sp.getString("profile_image") ?? "";
  }

  Future<void> getComments() async {
    setState(() => isLoading = true);
    var response = await _crud.getRequest(
      "$viewComments?ask_id=${widget.modelAsk.questionsId}",
    );

    try {
      if (response != null && response['status'] == 'success') {
        List fullComments = response['data'];

        setState(() {
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
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          commentsList = [];
        });
      }
    } catch (e) {
      print("Error fetching comments: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> addComment() async {
    if (_commentController.text.isEmpty) return;

    var response = await _crud.postRequest(addComments, {
      "com_text": _commentController.text,
      "doc_id": docId,
      "ask_id": widget.modelAsk.questionsId.toString(),
    });

    try {
      if (response != null && response['status'] == 'success') {
        _commentController.clear();
        await getComments();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Answer Question"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: QuestionsScreenDoc(),
              ),
            );
          },
          icon: Icon(CupertinoIcons.back),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getComments();
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
                                timeAgo(widget.modelAsk.postDate ?? ''),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Text("From User", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Divider(),
                      Text(
                        widget.modelAsk.questionsText ?? '',
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
                if (answer != null)
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
                                  answer!,
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  timeAgo(widget.modelAsk.postDate ?? ''),
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
                                  profileImage.isNotEmpty
                                      ? "$imageRoot/$profileImage"
                                      : "https://via.placeholder.com/150",
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Dr. $doctorName",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                specialty,
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
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    final comment = commentsList[index];
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
                                    "Answer:",
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
                                    timeAgo(commentDate),
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
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: "Add your comment...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: addComment,
                      child: Text("Send"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
