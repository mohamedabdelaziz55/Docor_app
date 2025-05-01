import 'package:doctor_app/constet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../crud.dart';
import '../../models/models_patient/model_date_json.dart';

class AddCommentScreen extends StatefulWidget {
  final Data modelAsk;

  const AddCommentScreen({super.key, required this.modelAsk});

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final Crud _crud = Crud();
  final TextEditingController _commentController = TextEditingController();
  List commentsList = [];
  bool isLoading = false;
  late String docId;

  Future<void> fetchDoctorId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    docId = sp.getString("id") ?? "";
  }

  Future<void> getComments() async {
    setState(() => isLoading = true);
    var response = await _crud.postRequest(viewComments, {
      "ask_id": widget.modelAsk.questionsId.toString(),
    });

    if (response['status'] == 'success') {
      commentsList = response['data'];
    }

    setState(() => isLoading = false);
  }

  Future<void> addComment() async {
    if (_commentController.text.isEmpty) return;
    var response = await _crud.postRequest(addComments, {
      "com_text": _commentController.text,
      "doc_id": docId,
      "ask_id": widget.modelAsk.questionsId.toString(),
    });

    if (response['status'] == 'success') {
      _commentController.clear();
      getComments();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDoctorId().then((_) => getComments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("سؤال وتعليقات")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.modelAsk.questionsText!, style: TextStyle(fontSize: 18)),
          ),
          Divider(),
          isLoading
              ? CircularProgressIndicator()
              : Expanded(
            child: ListView.builder(
              itemCount: commentsList.length,
              itemBuilder: (context, index) {
                final comment = commentsList[index];
                return ListTile(
                  title: Text(comment['com_text']),
                  subtitle: Text("بواسطة: د. ${comment['doc_name']}"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(comment['doc_profile']),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "أضف تعليقك...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addComment,
                  child: Text("إرسال"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
