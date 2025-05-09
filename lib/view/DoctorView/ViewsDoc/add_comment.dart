import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/ControllerDoctor/ViewsController/add_comment.dart';
import '../../../models/models_patient/model_date_json.dart';


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
