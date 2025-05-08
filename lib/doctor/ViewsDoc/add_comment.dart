import 'package:doctor_app/constet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../crud.dart';
import '../../models/models_patient/model_date_json.dart';

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

class AddCommentScreen extends StatelessWidget {
  final Data modelAsk;

  const AddCommentScreen({super.key, required this.modelAsk});

  @override
  Widget build(BuildContext context) {
    final AddCommentController controller = Get.put(AddCommentController());

    return Scaffold(
      appBar: AppBar(title: Text("Question and Comments")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(modelAsk.questionsText!, style: TextStyle(fontSize: 18)),
          ),
          Divider(),
          Obx(
                () => controller.isLoading.value
                ? CircularProgressIndicator()
                : Expanded(
              child: ListView.builder(
                itemCount: controller.commentsList.length,
                itemBuilder: (context, index) {
                  final comment = controller.commentsList[index];
                  return ListTile(
                    title: Text(comment['com_text']),
                    subtitle: Text("By: Dr. ${comment['doc_name']}"),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(comment['doc_profile']),
                    ),
                  );
                },
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                  onPressed: () => controller.addComment(modelAsk.questionsId.toString()),
                  child: Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
